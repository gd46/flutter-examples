import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  toRGBA() {
    return '$red,$green,$blue,$alpha';
  }
}
