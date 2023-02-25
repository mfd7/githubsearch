import 'package:flutter/material.dart';
import 'package:githubsearch/shared/constants/colors.dart';

ThemeData myTheme = ThemeData(
  primarySwatch: primary,
  fontFamily: 'Poppins',
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      ),
    ),
  ),
);
