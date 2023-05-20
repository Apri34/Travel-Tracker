import 'package:flutter/material.dart';
import 'package:travel_trackr/core/theme/app_colors.dart';

class CircularIcon extends StatelessWidget {
  final CircularIconSize size;
  final IconData icon;

  const CircularIcon({
    Key? key,
    this.size = CircularIconSize.big,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.size,
      height: size.size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor,
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: size.iconSize,
        ),
      ),
    );
  }
}

enum CircularIconSize { small, medium, big }

extension on CircularIconSize {
  double get size {
    switch (this) {
      case CircularIconSize.small:
        return 15;
      case CircularIconSize.medium:
        return 20;
      case CircularIconSize.big:
        return 30;
    }
  }

  double get iconSize {
    switch (this) {
      case CircularIconSize.small:
        return 8;
      case CircularIconSize.medium:
        return 7.5;
      case CircularIconSize.big:
        return 16;
    }
  }
}
