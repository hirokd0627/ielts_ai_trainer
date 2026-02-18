import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/features/home/home_controller.dart';
import 'package:ielts_ai_trainer/features/home/home_query_service.dart';
import 'package:ielts_ai_trainer/features/setting/setting_screen.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:provider/provider.dart';

/// Route path for Setting screen
final settingScreenRoutPath = '/setting';

/// GoRoute for Setting screen
final settingRoute = GoRoute(
  path: settingScreenRoutPath,
  builder: (BuildContext context, GoRouterState state) {
    return Provider<HomeController>(
      create: (_) => HomeController(
        queryService: HomeQueryService(context.read<AppDatabase>()),
      ),
      child: const SettingScreen(),
    );
  },
);
