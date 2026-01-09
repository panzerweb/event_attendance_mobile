import 'package:event_attendance_mobile/feature/present/presentation/attendees/pages/attendees_page.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/pages/add_event.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/pages/dashboard_view.dart';
import 'package:event_attendance_mobile/feature/present/presentation/event_details/pages/event_details.dart';
import 'package:event_attendance_mobile/feature/present/presentation/analytics/pages/overview.dart';
import 'package:event_attendance_mobile/feature/present/presentation/history/pages/history.dart';
import 'package:event_attendance_mobile/feature/profile/presentation/pages/about/about_app_screen.dart';
import 'package:event_attendance_mobile/feature/profile/presentation/pages/privacy/privacy_data_screen.dart';
import 'package:event_attendance_mobile/feature/profile/presentation/pages/profile_page.dart';
import 'package:event_attendance_mobile/feature/profile/presentation/pages/set_profile_page.dart';
import 'package:event_attendance_mobile/homepage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*
  GOROUTER

  Entire application's main routing logic

*/

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
            // Routes associated with Dashboard
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
            GoRoute(
              path: 'attendees',
              builder: (context, state) {
                return const AttendeesPage();
              },
            ),
          ],
        ),

        // Tabs here...
        GoRoute(
          path: '/overview',
          builder: (context, state) => const Overview(),
        ),
        GoRoute(path: '/history', builder: (context, state) => const History()),
      ],
    ),
    // Profile Routes
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
      routes: [
        GoRoute(
          path: 'user',
          builder: (context, state) => const SetProfilePage(),
        ),
        GoRoute(
          path: 'about',
          builder: (context, state) => const AboutAppScreen(),
        ),
        GoRoute(
          path: 'privacy',
          builder: (context, state) => const PrivacyDataScreen(),
        ),
      ],
    ),
  ],
);
