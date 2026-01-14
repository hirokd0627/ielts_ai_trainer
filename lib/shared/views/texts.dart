import 'package:flutter/material.dart';

class ScreenTitlteText extends StatelessWidget {
  final String text;

  const ScreenTitlteText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.only(top: 0, bottom: 0), // TODO:
      child: Text(text, style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}

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
