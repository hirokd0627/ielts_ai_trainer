import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts_ai_trainer/app/theme/app_colors.dart';

/// PageTransitionsBuilder with no animation
class _NoTransitionPageBuilder extends PageTransitionsBuilder {
  const _NoTransitionPageBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

/// PageTransitionsTheme with no animation between screens
final _pageTransitionsTheme = const PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.macOS: _NoTransitionPageBuilder(),
    TargetPlatform.windows: _NoTransitionPageBuilder(),
    // This app does not support Android, iOS, and Linux.
    TargetPlatform.android: _NoTransitionPageBuilder(),
    TargetPlatform.iOS: _NoTransitionPageBuilder(),
    TargetPlatform.linux: _NoTransitionPageBuilder(),
  },
);

/// Application theme data
final themeData = ThemeData(
  splashFactory: NoSplash.splashFactory, // no ripple effect
  highlightColor: Colors.transparent,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0F0F0F),
    onPrimary: Colors.white,
    secondary: Colors.orange,
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: AppColors.textColor,
    onSurfaceVariant: AppColors.secondaryTextColor,
    error: Colors.red,
    onError: Colors.white,
  ),
  pageTransitionsTheme: _pageTransitionsTheme,
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppColors.textColor,
        height: 1.2,
      ),
    ),
    headlineMedium: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w500,
        color: AppColors.textColor,
        height: 1.2,
      ),
    ),
    headlineSmall: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColors.textColor,
        height: 1.2,
      ),
    ),
    titleMedium: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.textColor,
        height: 1.2,
      ),
    ),
  ),
);
