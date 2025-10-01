import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:routine_maker/app.dart'; 
import 'package:routine_maker/features/chart/presentation/pages/chart_screen.dart';
import 'package:routine_maker/features/note/presentation/pages/note_screen.dart';
import 'package:routine_maker/features/routine/presentation/pages/routine_list_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true, 

    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return App(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chart',
                builder: (context, state) => const ChartScreen(), // صفحه روتین شما
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const RoutineListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/note',
                builder: (context, state) => const NoteScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
