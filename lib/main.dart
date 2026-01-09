import 'package:event_attendance_mobile/core/components/text_scale_cubit.dart';
import 'package:event_attendance_mobile/core/config/database_helper.dart';
import 'package:event_attendance_mobile/core/routes/app_routes.dart';
import 'package:event_attendance_mobile/feature/present/data/repository/attendee_repoimpl.dart';
import 'package:event_attendance_mobile/feature/present/data/repository/event_repoimpl.dart';
import 'package:event_attendance_mobile/feature/present/presentation/attendees/bloc/attendee_cubit.dart';
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
  final attendeeRepository = AttendeeRepoimpl(db: sqlFliteDb);

  // So the Cubit has an application-wide lifecycle and is accessible across all routes
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => EventCubit(eventRepository),
        ),
        BlocProvider(
          create: (BuildContext context) => AttendeeCubit(attendeeRepository),
        ),
        BlocProvider(create: (BuildContext context) => TextScaleCubit()),
      ],
      child: const MyApp(),
    ),
    // BlocProvider(
    //   create: (_) => EventCubit(eventRepository),
    //   child: const MyApp(), //Now EventCubit is available to all the routes
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextScaleCubit, double>(
      builder: (context, textScale) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(textScale)),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          ),
        );
      },
    );
  }
}
