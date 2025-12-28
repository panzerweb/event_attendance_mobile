import 'package:event_attendance_mobile/core/config/database_helper.dart';
import 'package:event_attendance_mobile/core/routes/app_routes.dart';
import 'package:event_attendance_mobile/feature/present/data/repository/event_repoimpl.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/bloc/event_cubit.dart';
import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sqlFliteDb = DatabaseHelper.instance;

  final eventRepository = EventRepoimpl(sqlFliteDb);

  // Provide the Bloc here since we are using GoRouter to route to the page
  runApp(
    BlocProvider(
      create: (_) => EventCubit(eventRepository),
      child: const MyApp(), //Now EventCubit is available to all the routes
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
