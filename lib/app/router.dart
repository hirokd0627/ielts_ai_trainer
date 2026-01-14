import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/features/development/development_route.dart';
import 'package:ielts_ai_trainer/features/home/home_route.dart';

/// Route configuration
///
/// Page transition animation is set in ThemeData.
final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    // Home screen
    homeRoute,
    // Development screen
    if (kDebugMode) developmentRoute,
  ],
);
