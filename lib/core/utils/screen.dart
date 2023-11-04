// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';

class Screen {
  static double get height => MediaQuery.of(useContext()).size.height;
  static double get width => MediaQuery.of(useContext()).size.width;
  static double get keyboard => MediaQuery.of(useContext()).viewInsets.bottom;
}
