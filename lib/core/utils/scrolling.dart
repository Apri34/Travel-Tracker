import 'package:flutter/material.dart';

extension Scrolling on ScrollController {
  void toBottom() => jumpTo(position.maxScrollExtent);

  void toTop() => jumpTo(0);
}
