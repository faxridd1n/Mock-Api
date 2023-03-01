import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mock_api/model/user_model.dart';

import '../home_page.dart';

Widget userItem(
    BuildContext context, UserModel user, void Function() openBottom,
    {required void Function() delete}) {
  return SizedBox(
    height: 80,
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              user.phone,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Divider(thickness: 2)
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: openBottom,
              icon: const Icon(
                Icons.edit,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: delete,
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ],
        ),
        
      ],
    ),
  );
}
