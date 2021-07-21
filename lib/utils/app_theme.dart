import 'package:flutter/material.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
      shadowColor: CustomColors.whiteLight,
      primaryIconTheme: IconThemeData(color: CustomColors.greyDark),
      accentIconTheme: IconThemeData(color: CustomColors.greyLight),
      iconTheme: IconThemeData(color: CustomColors.black),
      scaffoldBackgroundColor: CustomColors.whiteLight,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: CustomColors.black)),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              color: CustomColors.black,
              fontFamily: "GilroyLight",
              fontSize: 14),
          caption: TextStyle(color: CustomColors.greyDark)),
      bottomAppBarColor: Colors.white,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.white),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: CustomColors.purpleLight));

  static final ThemeData darkTheme = ThemeData(
      shadowColor: CustomColors.black,
      primaryIconTheme: IconThemeData(color: CustomColors.greyLight),
      iconTheme: IconThemeData(color: Colors.white),
      accentIconTheme: IconThemeData(color: CustomColors.black),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
          backgroundColor: CustomColors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white)),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              color: CustomColors.whiteLight,
              fontFamily: "GilroyLight",
              fontSize: 14),
          caption: TextStyle(color: CustomColors.greyLight)),
      bottomAppBarColor: CustomColors.black,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: CustomColors.black,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: CustomColors.purpleLightFaded));
}
