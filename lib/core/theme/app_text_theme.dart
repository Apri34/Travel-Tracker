import 'package:flutter/material.dart';

abstract class AppTextTheme {
  static TextStyle getHintStyle(double animation) => TextStyle(
        fontSize: 12 + (1 - animation) * 4,
        color: Colors.white.withOpacity(0.6),
      );
  static const TextStyle textFieldStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
}
