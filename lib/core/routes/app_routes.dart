import 'package:event_attendance_mobile/feature/present/presentation/dashboard/pages/add_event.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/pages/dashboard_view.dart';
import 'package:event_attendance_mobile/feature/present/presentation/event_details/pages/event_details.dart';
import 'package:event_attendance_mobile/feature/present/presentation/analytics/pages/overview.dart';
import 'package:event_attendance_mobile/feature/present/presentation/history/pages/history.dart';
import 'package:event_attendance_mobile/feature/present/presentation/settings/pages/settings.dart';
import 'package:event_attendance_mobile/homepage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Homepage(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardView(),
          routes: [
            GoRoute(
              path: 'event',
              builder: (context, state) {
                return const AddEvent();
              },
            ),
            GoRoute(
              path: 'event/:eventId',
              builder: (context, state) {
                return EventDetails(eventId: state.pathParameters['eventId']!);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/overview',
          builder: (context, state) => const Overview(),
        ),
        GoRoute(path: '/history', builder: (context, state) => const History()),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const Settings(),
        ),
      ],
    ),
  ],
);
