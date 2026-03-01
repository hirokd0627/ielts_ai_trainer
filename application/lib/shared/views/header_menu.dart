import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/app/theme/app_colors.dart';
import 'package:ielts_ai_trainer/features/development/development_route.dart';
import 'package:ielts_ai_trainer/features/home/home_route.dart';
import 'package:ielts_ai_trainer/features/setting/setting_route.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_routes.dart';
import 'package:ielts_ai_trainer/features/writing/writing_routes.dart';

/// Common header for screens
class HeaderMenuBar extends StatefulWidget {
  const HeaderMenuBar({super.key});

  @override
  State<HeaderMenuBar> createState() => _HeaderMenuBarState();
}

/// State for HeaderMenuBar
class _HeaderMenuBarState extends State<HeaderMenuBar> {
  /// Submenu style
  final _subMenuStyle = MenuStyle(
    elevation: WidgetStatePropertyAll(4),
    surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    shadowColor: WidgetStatePropertyAll(AppColors.dropShadow),
    backgroundColor: WidgetStatePropertyAll(Colors.white),
    alignment: Alignment.bottomLeft,
  );

  /// Builds widgets for MenuBar.
  List<Widget> _buildMenuBarWidgets() {
    final menuButtonStyle = ButtonStyle(
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.textColor,
          height: 1.2,
        ),
      ),
      overlayColor: WidgetStatePropertyAll(
        Colors.black.withValues(alpha: 0.02),
      ),
      padding: WidgetStatePropertyAll(
        EdgeInsets.only(top: 24, bottom: 24, left: 0, right: 0),
      ),
    );

    final subMenuButtonStyle = ButtonStyle(
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontWeight: FontWeight.w500, color: AppColors.textColor),
      ),
      overlayColor: WidgetStatePropertyAll(
        Colors.black.withValues(alpha: 0.02),
      ),
      padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
    );

    final menuWidth = 100.0;

    return [
      SizedBox(width: 4),
      // Logo
      MenuItemButton(
        onPressed: () {
          context.go(homeScreenRoutPath);
        },
        style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
              height: 1.2,
            ),
          ),
          backgroundColor: WidgetStateColor.transparent,
          shadowColor: WidgetStateColor.transparent,
          overlayColor: WidgetStateColor.transparent,
          padding: WidgetStatePropertyAll(
            EdgeInsets.only(top: 18, bottom: 6, left: 0, right: 0),
          ),
        ),
        // child: Text('IELTS Trainer'),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(Icons.smart_toy_outlined, size: 32),
            SizedBox(width: 6),
            Text('IELTS AI Trainer'),
          ],
        ),
      ),

      SizedBox(width: 30),

      // Home
      MenuItemButton(
        style: menuButtonStyle,
        onPressed: () {
          context.go(homeScreenRoutPath);
        },
        child: SizedBox(
          width: menuWidth,
          child: const Text('Home', textAlign: TextAlign.center),
        ),
      ),

      // Writing
      SubmenuButton(
        style: menuButtonStyle,
        menuStyle: _subMenuStyle,
        menuChildren: [
          MenuItemButton(
            onPressed: () {
              context.go(writingTask1QuestionGeneratorScreenRoutePath);
            },
            style: subMenuButtonStyle,
            child: SizedBox(
              width: menuWidth,
              child: const Text('Task 1', textAlign: TextAlign.center),
            ),
          ),
          MenuItemButton(
            onPressed: () {
              context.go(writingTask2QuestionGeneratorScreenRoutePath);
            },
            style: subMenuButtonStyle,
            child: SizedBox(
              width: menuWidth,
              child: const Text('Task 2', textAlign: TextAlign.center),
            ),
          ),
        ],
        child: SizedBox(
          width: menuWidth,
          child: const Text('Writing', textAlign: TextAlign.center),
        ),
      ),

      /// Speaking
      SubmenuButton(
        style: menuButtonStyle,
        menuStyle: _subMenuStyle,
        menuChildren: [
          MenuItemButton(
            onPressed: () {
              context.go(speakingPart1QuestionGeneratorScreenRoutePath);
            },
            style: subMenuButtonStyle,
            child: SizedBox(
              width: menuWidth,
              child: const Text('Part 1', textAlign: TextAlign.center),
            ),
          ),
          MenuItemButton(
            onPressed: () {
              context.go(speakingPart2QuestionGeneratorScreenRoutePath);
            },
            style: subMenuButtonStyle,
            child: SizedBox(
              width: menuWidth,
              child: const Text('Part 2', textAlign: TextAlign.center),
            ),
          ),
          MenuItemButton(
            onPressed: () {
              context.go(speakingPart3QuestionGeneratorScreenRoutePath);
            },
            style: subMenuButtonStyle,
            child: SizedBox(
              width: menuWidth,
              child: const Text('Part 3', textAlign: TextAlign.center),
            ),
          ),
        ],
        child: SizedBox(
          width: menuWidth,
          child: const Text('Speaking', textAlign: TextAlign.center),
        ),
      ),

      /// Setting
      MenuItemButton(
        style: menuButtonStyle,
        onPressed: () {
          context.go(settingScreenRoutPath);
        },
        child: SizedBox(
          width: menuWidth,
          child: const Text('Setting', textAlign: TextAlign.center),
        ),
      ),

      // Development
      MenuItemButton(
        style: menuButtonStyle,
        onPressed: () {
          context.go(developmentScreenRoutePath);
        },
        child: SizedBox(
          width: menuWidth,
          child: const Text('Development', textAlign: TextAlign.center),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: MenuBar(
            style: MenuStyle(
              // padding: WidgetStatePropertyAll(
              //   EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              // ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              elevation: WidgetStatePropertyAll(4),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
              shadowColor: WidgetStatePropertyAll(AppColors.dropShadow),
            ),

            children: _buildMenuBarWidgets(),
          ),
        ),
      ],
    );
  }
}
