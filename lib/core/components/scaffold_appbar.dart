import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*
  COMPONENT FOLDER: Common widgets that are reusable to the entire application

  Main appbar for appbar argument in the 
  Scaffold widget as a PreferredSizeWidget

  Note:
    Leading should be the official logo of the app

    Title can be the App name, or a tab's title

    Actions should have a Profile button that leads to a route for profile
    page.


  Usage:
    appbar: ScaffoldAppBar(title: string),
*/

class ScaffoldAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? username;
  final VoidCallback? onProfileUpdate;

  const ScaffoldAppbar({
    super.key,
    required this.title,
    this.username,
    this.onProfileUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      foregroundColor: Palette.textPrimary,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/logo/transparent_logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
      centerTitle: true,
      title: Center(
        child: Text(
          title,
          style: TextStyle(color: Palette.textPrimary, fontSize: 18),
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () async {
            await context.push('/profile');
            if (onProfileUpdate != null) {
              onProfileUpdate!(); // reload dashboard username
            }
          },
          icon: Icon(Icons.person),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0);
}
