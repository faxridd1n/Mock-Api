

import 'package:dio/dio.dart';
import 'package:mock_api/model/user_model.dart';

import '../core/api/api.dart';
import '../core/config/dio_config.dart';
import '../view/home_page.dart';
import 'log_service.dart';
class UserService {
  static final UserService _inheritance = UserService._init();

  static UserService get inheritance => _inheritance;

  UserService._init();

  static Future<List<UserModel>?> getUsers() async {

    try {
      Response res =
      await DioConfig.inheritance.createRequest().get(Urls.getUsers);
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200) {
        List<UserModel> userList = [];
        for (var e in (res.data as List)) {
          userList.add(UserModel.fromJson(e));
        }

        return userList;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
    }
    return null;
  }


  static Future<bool> createUser(UserModel newUser) async {
    try {
      Response res = await DioConfig.inheritance
          .createRequest()
          .post(Urls.addUser,
          data: {
            "name": newUser.name,
            "phone": newUser.phone,
            "age": newUser.age,
            "gender": newUser.gender,
            "passport": newUser.passport,
            "familyMembers": newUser.familyMembers
          });
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
        return false;
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
      return false;
    }
  }
/*
  static Future<bool> editUser(UserModel newUser) async {
    try {
      Response res = await DioConfig.inheritance
          .createRequest()
          .put(Urls.updateUser + newUser.id.toString(), data: {
        "userId": newUser.userId,
        "title": newUser.title,
        "body": newUser.body
      });
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
        return false;
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
      return false;
    }
  }
*/

  static Future<bool> deleteUser(String id,) async {
    try {
      Response res = await DioConfig.inheritance
          .createRequest()
          .delete(Urls.deleteUser + id,);
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
        return false;
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
      return false;
    }
  }


  
  static Future<bool> editUser(String id,UserModel user) async {
    try {
      Response res = await DioConfig.inheritance
          .createRequest().put(Urls.editUser + id,data: {
            "name":t1.text.toString(),
            "age":int.parse(t2.text),
            "phone":t3.text.toString(),
            "gender":user.gender.toString(),
          });
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
        return false;
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
      return false;
    }
  }
}