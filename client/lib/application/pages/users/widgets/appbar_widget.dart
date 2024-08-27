import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? widgetAction;
  final ThemeData themeData;
  const AppBarWidget(
      {Key? key,
      required this.title,
      required this.widgetAction,
      required this.themeData})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.grey.shade400,
      centerTitle: true,
      title: Text(
        title!,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions: [widgetAction!],
    );
  }
}
