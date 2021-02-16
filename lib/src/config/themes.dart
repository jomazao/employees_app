import 'package:employees_app/src/config/app_colors.dart';
import 'package:flutter/material.dart';

class Themes {
  ThemeData ligthTheme = ThemeData(
    backgroundColor: AppColors.backgroundColor,
    cardColor: AppColors.secondaryColor,
    primarySwatch: MaterialColor(AppColors.primaryColor.value, {
      50: AppColors.primaryColor,
      100: AppColors.secondaryColor,
      200: AppColors.secondaryColor,
      300: AppColors.secondaryColor,
      400: AppColors.secondaryColor,
      500: AppColors.primaryColor,
      600: AppColors.secondaryColor,
      700: AppColors.secondaryColor,
      800: AppColors.secondaryColor,
    }),
    appBarTheme: AppBarTheme(
      color: AppColors.primaryColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
    buttonColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: TextTheme(
      headline6: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: AppColors.palePink,
      ),
      headline5: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headline4: TextStyle(
        fontSize: 15,
        color: AppColors.red,
      ),
      headline3: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.darkBlue,
      ),
      headline2: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppColors.darkBlue,
      ),
      headline1: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        color: AppColors.green,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: AppColors.green,
      ),
      focusColor: AppColors.green,
      fillColor: AppColors.green,
      hoverColor: AppColors.green,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.green,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.green,
          width: 2.0,
        ),
      ),
    ),
  );
}
