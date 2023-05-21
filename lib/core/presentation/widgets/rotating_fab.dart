import 'dart:math';

import 'package:flutter/material.dart';

class RotatingFab extends StatefulWidget {
  final void Function(bool active) onPressed;

  const RotatingFab({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<RotatingFab> createState() => _RotatingFabState();
}

class _RotatingFabState extends State<RotatingFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
    reverseDuration: const Duration(seconds: 1),
  );
  late final Animation<double> _animation =
      Tween<double>(begin: 0, end: pi * 2.25).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ),
  )..addListener(() {
          setState(() {});
        });
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Transform.rotate(
        angle: _animation.value,
        child: const Icon(Icons.add, size: 36,),
      ),
      onPressed: () {
        setState(() {
          active = !active;
        });
        widget.onPressed(active);
        if (active) {
          _animationController.forward(from: 0);
        } else {
          _animationController.reverse(from: 6.25);
        }
      },
    );
  }
}
