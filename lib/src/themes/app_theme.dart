import 'package:flutter/material.dart';

class AppTheme {
  static const Color colorCard = Color.fromARGB(255, 149, 189, 220);
  static const Color colorPrimary = Color.fromARGB(255, 70, 80, 130);
  static final Color colorPrimaryLight = Colors.lightBlue.shade100;
  static final Color colorSecondaryLight = Colors.lightBlue.shade200;
  static const Color colorFocus = Color.fromARGB(255, 240, 230, 20);
  static final Color colorAlert = Colors.red;
  static final Color colorIndicator = Colors.lightBlue.shade800;

  static final TextTheme _textTheme = TextTheme(
    headline1: _headLine1,
    headline2: _headLine2,
    headline3: _headLine3,
    headline4: _headLine4,
    headline5: _headLine5,
    headline6: _headLine6,
    bodyText1: _bodyText1,
    bodyText2: _bodyText2,
    subtitle1: _subTitle1,
    subtitle2: _subTitle2,
    caption: _caption,
  );

  static const TextStyle _headLine1 =
      TextStyle(fontFamily: 'Nexa', fontWeight: FontWeight.bold);

  static final TextStyle _headLine2 = _headLine1.copyWith();
  static final TextStyle _headLine3 = _headLine2.copyWith();
  static final TextStyle _headLine4 = _headLine3.copyWith();
  static final TextStyle _headLine5 = _headLine4.copyWith();
  static final TextStyle _headLine6 =
      _headLine5.copyWith(fontFamily: 'Akrobat');
  static final TextStyle _subTitle1 = _headLine6.copyWith();
  static final TextStyle _subTitle2 = _subTitle1.copyWith();
  static final TextStyle _bodyText1 = _subTitle2.copyWith();
  static final TextStyle _bodyText2 = _bodyText1.copyWith();
  static final TextStyle _caption = _bodyText2.copyWith();

  static ThemeData themeData(bool ligthMode) {
    return ThemeData(
      textTheme: _textTheme,
      brightness: ligthMode ? Brightness.light : Brightness.dark,
    );
  }
}
