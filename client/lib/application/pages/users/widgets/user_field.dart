import 'package:flutter/material.dart';

class UserField extends StatelessWidget {
  final String userList;
  const UserField({super.key, required this.userList});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(15),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: themeData.colorScheme.onPrimary),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              '''" $userList "''',
              style: themeData.textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
