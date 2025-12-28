import 'package:event_attendance_mobile/core/components/scaffold_appbar.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: ScaffoldAppbar(title: "Settings"));
  }
}
