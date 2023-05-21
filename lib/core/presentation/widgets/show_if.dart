import 'package:flutter/material.dart';

class ShowIf extends StatelessWidget {
  final Widget child;
  final bool show;
  final Duration? duration;

  const ShowIf({
    Key? key,
    required this.show,
    required this.child,
    this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: const SizedBox.shrink(),
      secondChild: child,
      crossFadeState:
          show ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: duration ?? const Duration(milliseconds: 200),
    );
  }
}
