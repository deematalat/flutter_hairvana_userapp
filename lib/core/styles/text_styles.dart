import 'package:flutter/material.dart';

class AppTextStyles {

  static const String _fontFamily = 'Poppins';

  static TextStyle largeTitle({Color color = Colors.black, double? fontSize}) => TextStyle(
    fontSize: fontSize ?? 44,
    fontWeight: FontWeight.w900,
    color: color,
    letterSpacing: 1.5,
    fontFamily: _fontFamily,
    height: 1.18,
  );

  static TextStyle title({Color color = Colors.black, double? fontSize}) => TextStyle(
    fontSize: fontSize ?? 30,
    fontWeight: FontWeight.w800,
    color: color,
    letterSpacing: 1.1,
    fontFamily: _fontFamily,
    height: 1.18,
  );

  static TextStyle subtitle({Color color = Colors.black87, double? fontSize}) => TextStyle(
    fontSize: fontSize ?? 20,
    fontWeight: FontWeight.w500,
    color: color,
    letterSpacing: 0.5,
    fontFamily: _fontFamily,
    height: 1.35,
  );

  static TextStyle body({Color color = Colors.black54, double? fontSize, FontWeight? fontWeight}) => TextStyle(
    fontSize: fontSize ?? 16,
    color: color,
    fontWeight: fontWeight ?? FontWeight.w400,
    fontFamily: _fontFamily,
    height: 1.5,
  );

  static TextStyle button({Color color = Colors.white, double fontSize = 20, FontWeight fontWeight = FontWeight.w700}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: 0.7,
      fontFamily: _fontFamily,
      height: 1.18,
    );
  }
}