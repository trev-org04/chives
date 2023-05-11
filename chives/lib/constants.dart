import 'package:flutter/material.dart';

const Color white = Color(0xFFFFFFFF);
const Color textWhite = Color(0xFFF1F4ED);
const Color errorColor = Color(0xFFC05858);
const Color offWhite = Color(0xFFC1C5B7);
const Color disabledStarColor = Color(0xFF777970);
const Color inputColor = Color(0xFF777970);
const Color lightGreen = Color(0xFF97B166);
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

String capitalizeItemTitle(String title) {
  String capTitle = "";
  int initIndex = 0, index = 0;
  List<String> words = [], newCapWords = [];

  while (index < title.length) {
    String sub = title.substring(index, index + 1);
    if (sub == " " || index == title.length - 1) {
      if (initIndex == 0) {
        words.add(title.substring(initIndex, index + 1));
      } else {
        words.add(title.substring(initIndex - 1, index + 1));
      }
      initIndex = index + 1;
    }
    index++;
  }
  for (String word in words) {
    Set<String> capWords = {'bbq', 'blt'};
    if (word.substring(0, 1) == " ") {
      word = word.substring(1);
    }
    if (capWords.contains(word)) {
      newCapWords.add(word.toUpperCase());
    } else {
      String firstChar = word.substring(0, 1);
      String endOfWord = word.substring(1);
      newCapWords.add(firstChar.toUpperCase() + endOfWord);
    }
  }
  for (String word in newCapWords) {
    if (word.substring(word.length - 1) == " ") {
      capTitle = "$capTitle$word";
    } else {
      capTitle = "$capTitle$word ";
    }
  }
  return capTitle;
}

String reduceTitle(String title) {
  String reducedTitle = title;
  if (title.length >= 15) {
    reducedTitle = '${title.substring(0, 16)}...';
  }
  return reducedTitle;
}
