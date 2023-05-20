import 'package:flutter/material.dart';

class AppAlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}