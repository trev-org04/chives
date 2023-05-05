import 'package:flutter/material.dart';

const Color textWhite = Color(0xFFE6EBE0);
const Color errorColor = Color(0xFFD95A5A);
const Color offWhite = Color(0xFFCDD2C0);
const Color inputColor = Color(0xFF777970);
const Color lightGreen = Color(0xFFA6C36F);
const Color mediumGreen = Color(0xFF828C51);
const Color darkGreen = Color(0xFF565C36);
const Color background = Color(0xFF232020);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
