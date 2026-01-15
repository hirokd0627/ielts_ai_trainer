import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/features/development/development_route.dart';
import 'package:ielts_ai_trainer/features/home/home_route.dart';
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
    elevation: WidgetStateProperty.all(0),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    ),
  );

  /// Builds widgets for MenuBar.
  List<Widget> _buildMenuBarWidgets() {
    return [
      // Logo
      MenuItemButton(
        onPressed: () {
          context.go(homeScreenRoutPath);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateColor.transparent,
          overlayColor: WidgetStateColor.transparent,
          shadowColor: WidgetStateColor.transparent,
          padding: WidgetStatePropertyAll(EdgeInsets.fromLTRB(0, 0, 30, 0)),
        ),
        child: SizedBox(child: Text('IELTS Trainer')),
      ),

      // Home
      MenuItemButton(
        onPressed: () {
          context.go(homeScreenRoutPath);
        },
        child: const Text('Home'),
      ),

      // Writing
      SubmenuButton(
        menuStyle: _subMenuStyle,
        menuChildren: [
          MenuItemButton(
            onPressed: () {
              context.go(writingTask1QuestionGeneratorScreenRoutePath);
            },
            child: const Text('Task 1'),
          ),
          MenuItemButton(
            onPressed: () {
              context.go(writingTask2QuestionGeneratorScreenRoutePath);
            },
            child: const Text('Task 2'),
          ),
        ],
        child: const Text('Writing'),
      ),

      /// Speaking
      SubmenuButton(
        menuStyle: _subMenuStyle,
        menuChildren: [
          MenuItemButton(onPressed: () {}, child: const Text('Part 1')),
          MenuItemButton(onPressed: () {}, child: const Text('Part 2')),
          MenuItemButton(onPressed: () {}, child: const Text('Part 3')),
        ],
        child: const Text('Speaking'),
      ),

      /// Setting
      MenuItemButton(onPressed: () {}, child: const Text('Setting')),

      // Development
      if (kDebugMode)
        SubmenuButton(
          menuStyle: _subMenuStyle,
          menuChildren: [
            MenuItemButton(
              onPressed: () {
                context.go(developmentScreenRoutePath);
              },
              child: const Text('Reset DB'),
            ),
          ],
          child: const Text('Development'),
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
            style: MenuStyle(elevation: WidgetStatePropertyAll(0)),
            children: _buildMenuBarWidgets(),
          ),
        ),
      ],
    );
  }
}
