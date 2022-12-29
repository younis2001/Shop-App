import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme=ThemeData(
    bottomNavigationBarTheme:
    BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        elevation: 20.0),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:  AppBarTheme(
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
    ),
    textTheme:  TextTheme(
        bodyText1: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black)));
ThemeData darkTheme=ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: HexColor('333739'),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      elevation: 20.0),
  appBarTheme: AppBarTheme(
    titleTextStyle:  TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light),
  ),
  textTheme:  TextTheme(
      bodyText1: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.white)),
);
