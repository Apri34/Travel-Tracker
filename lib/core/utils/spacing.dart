import 'package:flutter/material.dart';

extension Spacing on double {
  SizedBox get horizontalSpace => SizedBox(width: this);

  SizedBox get verticalSpace => SizedBox(height: this);
}
