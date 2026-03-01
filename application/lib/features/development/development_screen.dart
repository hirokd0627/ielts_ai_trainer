import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/database/app_database_dev.dart';
import 'package:ielts_ai_trainer/shared/logging/logger.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';
import 'package:provider/provider.dart';

/// Development screen that provides development-only functions
class DevelopmentScreen extends StatelessWidget {
  const DevelopmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logger = createLogger('DevelopmentScreenState');
    final db = context.read<AppDatabase>();

    return BaseScreenScaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          // Button to erase database all data
          TextButton(
            onPressed: () async {
              await db.eraseAll();
              logger.d('Erase data completed');
            },
            child: Text("Erase DB data"),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () async {
              await db.ungradeAll();
              logger.d('Clear graded');
            },
            child: Text("Set Ungrade All"),
          ),
        ],
      ),
    );
  }
}
