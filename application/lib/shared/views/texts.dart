import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Text widget styled as a screen title.
class ScreenTitleText extends StatelessWidget {
  final String text;

  const ScreenTitleText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.only(top: 0, bottom: 0),
      child: Text(text, style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}

/// Text widget styled as a headline text.
class HeadlineText extends StatelessWidget {
  final String text;
  final int level;

  const HeadlineText(this.text, {super.key, this.level = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(),
      padding: EdgeInsets.only(),
      child: Text(text, style: _getStyle(context)),
    );
  }

  TextStyle? _getStyle(BuildContext context) {
    if (level == 1) {
      return Theme.of(context).textTheme.headlineMedium;
    }
    return GoogleFonts.roboto(
      textStyle: TextStyle(fontWeight: FontWeight.w500),
    );
  }
}

/// Text widget styled as an input field label.
class FieldLabel extends StatelessWidget {
  final String text;

  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(),
      padding: EdgeInsets.only(),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

/// Text widget styled as an input error text.
class InputErrorText extends StatelessWidget {
  final String text;

  const InputErrorText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
