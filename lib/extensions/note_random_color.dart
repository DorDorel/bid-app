import 'dart:math' show Random;

import 'package:flutter/widgets.dart' show Color;

extension RandomColor on List<Color> {
  Color get randomColor {
    final random = Random();
    return this[random.nextInt(this.length)];
  }
}