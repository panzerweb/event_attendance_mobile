import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*
  Defines the bottom navigation bar
*/

class Homepage extends StatelessWidget {
  final Widget child;

  const Homepage({super.key, required this.child});

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/overview')) return 1;
    if (location.startsWith('/history')) return 2;

    // SETTINGS ROUTE DEPRECATED
    // if (location.startsWith('/settings')) return 3;

    return 0;
  }

  void _onTap(BuildContext context, int index) async {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/overview');
        break;
      case 2:
        context.go('/history');
        break;

      // SETTINGS ROUTE DEPRECATED
      // case 3:
      //   context.go('/settings');
      //   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Palette.primaryColor,
        fixedColor: Palette.textPrimary,
        unselectedItemColor: Palette.accentPurple,
        currentIndex: currentIndex,
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Analytics",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),

          // SETTINGS ROUTE DEPRECATED
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   label: "Settings",
          // ),
        ],
      ),
    );
  }
}
