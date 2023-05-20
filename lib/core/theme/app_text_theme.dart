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

  /// Destination Country
  static const TextStyle body = TextStyle(
    color: Colors.white,
    fontSize: 11,
  );

  /// Destination City
  static const TextStyle headline2 = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
}
