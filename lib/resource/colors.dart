import 'package:flutter/material.dart';

class Col {
  static const WHITE = Color.fromRGBO(255, 255, 255, 1);
  static const blue = Color.fromRGBO(0, 90, 156, 1);
  static const grey = Color.fromRGBO(177, 177, 177, 1);
  static const green = Color.fromRGBO(11, 210, 122, 1);
  static const darkgreen = Color.fromRGBO(58, 158, 127, 1);

  static const black = Color.fromRGBO(0, 0, 0, 1);
  static const lightgrey = Color.fromRGBO(239, 239, 239, 1);
  static const lightgreylite = Color.fromRGBO(225, 225, 225, 1);
  static const yellow = Color.fromRGBO(255, 213, 74, 1);
  static const dullyellow = Color.fromRGBO(228, 212, 93, 1);
  static const ksidePadding = 32.00;
  final Colsd = HexColor('#E5EDEF');
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
