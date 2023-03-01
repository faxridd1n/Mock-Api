import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mock_api/service/user_service.dart';

import '../../model/user_model.dart';
import '../../service/utils_service.dart';

class MyDialog extends StatefulWidget {
  MyDialog({Key? key}) : super(key: key);



  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String _gender = "male";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Enter Details"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: "male",
                    groupValue: _gender,
                    onChanged: (String? value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                  const Text("Male"),
                  const SizedBox(width: 10),
                  Radio(
                    value: "female",
                    groupValue: _gender,
                    onChanged: (String? value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                  const Text("Female"),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              UserModel newUser = UserModel(
                  name: _nameController.text,
                  phone: _phoneController.text,
                  age: int.parse(_ageController.text),
                  gender: _gender,
                  passport: 'AB1234567',
                  familyMembers: [],
                  id: "1") ;

              _createUser(newUser);

              Navigator.pop(context);

            }
          },
          child: const Text('SAVE'),
        ),
      ],
    );
  }

  void _createUser(UserModel newUser) async {
    bool result =
    await UserService.createUser(newUser);
    if (result) {
      setState(() {});
      Utils.snackBarSuccess(
          'Created successfully', context);
    } else {
      Utils.snackBarError('Someting is wrong', context);
    }
  }
}
