import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkTheme;
  final VoidCallback onThemeToggle;

  const MyAppBar({
    required this.isDarkTheme,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('TODO List'),
      actions: [
        IconButton(
          icon: Icon(
            isDarkTheme ? Icons.light_mode : Icons.dark_mode,
          ),
          onPressed: onThemeToggle,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
