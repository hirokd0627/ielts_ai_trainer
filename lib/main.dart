import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/router.dart';
import 'package:ielts_ai_trainer/app/theme/theme.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

final _appTitle = 'IELTS AI Trainer';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(800, 700),
    minimumSize: Size(800, 700),
    backgroundColor: Colors.transparent,
    title: _appTitle,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    Provider<AppDatabase>(
      create: (_) => AppDatabase(),
      dispose: (_, db) => db.close(),
      child: const MyApp(),
    ),
  );
}

/// Root widget of application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: _appTitle,
      theme: themeData,
      routerConfig: appRouter,
    );
  }
}
