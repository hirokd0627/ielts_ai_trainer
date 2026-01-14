import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/router.dart';
import 'package:ielts_ai_trainer/app/theme.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      title: 'Flutter Demo',
      theme: themeData,
      routerConfig: appRouter,
    );
  }
}
