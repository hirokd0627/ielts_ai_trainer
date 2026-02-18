import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/features/development/development_route.dart';
import 'package:ielts_ai_trainer/features/home/home_route.dart';
import 'package:ielts_ai_trainer/features/setting/setting_route.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_routes.dart';
import 'package:ielts_ai_trainer/features/writing/writing_routes.dart';

/// Route configuration
///
/// Page transition animation is set in ThemeData.
final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    // Home screen
    homeRoute,
    // Writing screens
    ...writingRoutes,
    // Speaking screens
    ...speakingRoutes,
    // Setting screen
    settingRoute,
    // Development screen
    developmentRoute,
  ],
);
