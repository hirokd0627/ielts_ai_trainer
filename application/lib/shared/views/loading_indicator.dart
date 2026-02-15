import 'package:flutter/material.dart';

/// An indicator representing loading.
class LoadingIndicator extends StatefulWidget {
  /// The message to show.
  final String message;

  const LoadingIndicator(this.message, {super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

/// State for LoadingIndicator.
class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _ctrl.repeat(reverse: true);

    // Fade-in and Fade-out.
    _animation = Tween<double>(begin: 0.2, end: 0.8).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: Text(widget.message));
  }
}
