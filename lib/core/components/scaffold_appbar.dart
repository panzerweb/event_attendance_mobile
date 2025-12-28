import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:flutter/material.dart';

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
  const ScaffoldAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryBackground,
      foregroundColor: Palette.textPrimary,
      leading: Icon(Icons.logo_dev),
      title: Center(
        child: Text(
          title,
          style: TextStyle(color: Palette.textPrimary, fontSize: 18),
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            // Utilize by GoRouter
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) {
            //       // Go to Profile Page
            //       context.push(location)
            //     },
            //   ),
            // );
          },
          icon: Icon(Icons.person),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0);
}
