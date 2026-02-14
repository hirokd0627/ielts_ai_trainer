import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/database/app_database_dev_seed.dart';
import 'package:ielts_ai_trainer/shared/logging/logger.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';
import 'package:provider/provider.dart';

/// Development screen that provides development-only functions
class DevelopmentScreen extends StatelessWidget {
  const DevelopmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      body: Column(
        children: [
          // Button to erase database all data
          TextButton(
            onPressed: () async {
              final db = context.read<AppDatabase>();
              final logger = createLogger('DevelopmentScreenState');

              await db.eraseAll();
              logger.d('Erase data completed');
            },
            child: Text("Erase DB data"),
          ),
        ],
      ),
    );
  }
}
