import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/features/home/home_controller.dart';
import 'package:ielts_ai_trainer/features/home/home_query_service.dart';
import 'package:ielts_ai_trainer/features/home/home_screen.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:provider/provider.dart';

/// Route path for Home screen
final homeScreenRoutPath = '/';

/// GoRoute for Home screen
final homeRoute = GoRoute(
  path: homeScreenRoutPath,
  builder: (BuildContext context, GoRouterState state) {
    return Provider<HomeContoller>(
      create: (_) => HomeContoller(
        queryService: HomeQueryService(context.read<AppDatabase>()),
      ),
      child: const HomeScreen(),
    );
  },
);
