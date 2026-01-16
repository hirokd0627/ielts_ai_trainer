import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  colorScheme: .fromSeed(seedColor: Colors.deepPurple),
  pageTransitionsTheme: _pageTransitionsTheme,
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.roboto(
      textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
    ),
    headlineMedium: GoogleFonts.roboto(
      textStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
    ),
    headlineSmall: GoogleFonts.roboto(
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
    ),
    titleMedium: GoogleFonts.roboto(
      textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    ),
  ),
);
