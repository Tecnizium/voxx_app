import 'package:flutter/material.dart';


abstract class AppTextTheme {
  static const String kFontFamily = 'ConcertOne';

  static TextStyle kTitle1({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 40,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color,
      );
  static TextStyle kTitle2({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 32,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color,
      );
  static TextStyle kTitle3({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 24,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color,
      );
  static TextStyle kBody1({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 18,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color,
      );
  static TextStyle kBody2({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color,
      );
  static TextStyle kBody3({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color,
      );
  static TextStyle kFootnote1({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 12,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color,
      );
  static TextStyle kFootnote2({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 11,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color,
      );
  static TextStyle kFootnote3({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 10,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color,
      );
}
