import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData materialTheme = ThemeData(
  fontFamily: 'Montserrat',
  elevatedButtonTheme: (ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: const Color(0xffB3DDC6)))),
  buttonTheme: const ButtonThemeData(buttonColor: Color(0xffB3DDC6)),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Color(0xff2c2c2c))),
  appBarTheme: const AppBarTheme(
    color: Color(0xfffaf7ed),
    iconTheme: IconThemeData(color: Colors.black),
    toolbarTextStyle: TextStyle(color: Color(0xff2c2c2c)),
    titleTextStyle: TextStyle(color: Color(0xff2c2c2c), fontSize: 20),
  ),
  primaryColor: const Color(0xfffaf7ed),
  scaffoldBackgroundColor: const Color(0xfffaf7ed),
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: const Color(0xffB3DDC6)),
);

CupertinoThemeData cupertinoTheme = const CupertinoThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xfffaf7ed),
    barBackgroundColor: Color(0xfffaf7ed),
    primaryColor: Color(0xffB3DDC6),
    primaryContrastingColor: Color(0xff2c2c2c),
    textTheme: CupertinoTextThemeData(
        navLargeTitleTextStyle: TextStyle(fontFamily: 'BakbakOne', color: Color(0xff2c2c2c)),
        navTitleTextStyle: TextStyle(fontFamily: 'BakbakOne', color: Color(0xff2c2c2c), fontSize: 20),
        primaryColor: Color(0xff2c2c2c),
        textStyle: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xff2c2c2c),
        )));
