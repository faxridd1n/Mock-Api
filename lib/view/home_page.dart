import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mock_api/model/user_model.dart';
import 'package:mock_api/service/user_service.dart';
import 'package:mock_api/view/widgets/addItem.dart';
import 'package:mock_api/view/widgets/user_item.dart';

import '../service/utils_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MyDialog();
                  },
                );
                setState(() {});
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: UserService.getUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return userItem(
                      context,
                      snapshot.data![index],
                      () {
                        t1.text = snapshot.data![index].name;
                        t2.text = snapshot.data![index].age.toString();
                        t3.text = snapshot.data![index].phone.toString();

                        _dialogBuilder(context, () {
                          setState(() {});
                        }, () {
                          _editUser(
                            snapshot.data![index].id,
                            snapshot.data![index],
                          );
                          Navigator.pop(context);
                        });
                      },
                      delete: () {
                        _deleteUser(
                          snapshot.data![index].id,
                        );
                      },
                    );
                  });
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('No data'),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void _deleteUser(
    String id,
  ) async {
    bool result = await UserService.deleteUser(id);
    if (result) {
      setState(() {});
      Utils.snackBarSuccess('Deleted successfully', context);
    } else {
      Utils.snackBarError('Someting is wrong', context);
    }
  }

  void _editUser(String id, UserModel user) async {
    bool result = await UserService.editUser(id, user);
    if (result) {
      setState(() {});
      Utils.snackBarSuccess('Deleted successfully', context);
    } else {
      Utils.snackBarError('Someting is wrong', context);
    }
  }
}

TextEditingController t1 = TextEditingController();

TextEditingController t2 = TextEditingController();

TextEditingController t3 = TextEditingController();

String _gender = "male";

Future<void> _dialogBuilder(
    BuildContext context, void Function() set, void Function() edit) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit'),
        content: Column(
          children: [
            TextFormField(
              controller: t1,
              decoration: InputDecoration(
                  hintText: 'name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: t2,
              decoration: InputDecoration(
                  hintText: 'age',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: t3,
              decoration: InputDecoration(
                  hintText: 'phone number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: "male",
                  groupValue: _gender,
                  onChanged: (String? value) {
                    _gender = value!;
                    set();
                  },
                ),
                const Text("Male"),
                const SizedBox(width: 10),
                Radio(
                  value: "female",
                  groupValue: _gender,
                  onChanged: (String? value) {
                    _gender = value!;
                    set();
                  },
                ),
                const Text("Female"),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Disable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Update'),
            onPressed: () {
              edit();
            },
          ),
        ],
      );
    },
  );
}
