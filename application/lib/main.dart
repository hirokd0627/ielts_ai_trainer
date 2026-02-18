import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/router.dart';
import 'package:ielts_ai_trainer/app/theme/theme.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/setting/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

/// The application title
const _appTitle = 'IELTS AI Trainer';

/// The application window size
const _windowSize = Size(800, 800);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _initiaizeWindow();

  // Init SharedPreferencesWithCache, need only once when app launched.
  AppSettings.init();

  runApp(
    Provider<AppDatabase>(
      create: (_) => AppDatabase(),
      dispose: (_, db) => db.close(),
      child: const MyApp(),
    ),
  );
}

/// Initialize the application window.
void _initiaizeWindow() async {
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: _windowSize,
    minimumSize: _windowSize,
    backgroundColor: Colors.white,
    title: _appTitle,
    center: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
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
