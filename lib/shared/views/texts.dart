import 'package:flutter/material.dart';

/// Text widget styled as a screen title.
class ScreenTitleText extends StatelessWidget {
  final String text;

  const ScreenTitleText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.only(top: 0, bottom: 0), // TODO:
      child: Text(text, style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}

/// Text widget styled as a headline text.
class HeadlineText extends StatelessWidget {
  final String text;

  const HeadlineText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(),
      padding: EdgeInsets.only(),
      child: Text(text, style: Theme.of(context).textTheme.headlineMedium),
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
