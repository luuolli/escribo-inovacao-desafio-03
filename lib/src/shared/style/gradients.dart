import 'package:flutter/cupertino.dart';

abstract class StarwarsGradient {
  static LinearGradient get darkGradient => const LinearGradient(
        colors: [
          Color(0xFF323232),
          Color(0xFF1E1E1E),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
