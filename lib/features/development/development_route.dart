import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/features/development/development_screen.dart';

/// Route path for Development screen
final developmentScreenRoutePath = '/development/reset-db';

/// GoRoute for Development screen
final developmentRoute = GoRoute(
  path: developmentScreenRoutePath,
  builder: (BuildContext context, GoRouterState state) {
    return const DevelopmentScreen();
  },
);
