import 'package:flutter/material.dart';

//color palette
/*
#ed6e3a	rgb(237, 110, 58)
#e9b08e	rgb(233, 176, 142)
#a4330d	rgb(164, 51, 13)
#6c9e4f	rgb(108, 158, 79)
#dbcdb5	rgb(219, 205, 181)
#5e3c2c	rgb(94, 60, 44)
*/

class MyThemes {
  // getting screen height and width to set the text
  static final width = WidgetsBinding.instance.window.physicalSize.width /
      WidgetsBinding.instance.window.devicePixelRatio;
  static final height = WidgetsBinding.instance.window.physicalSize.height /
      WidgetsBinding.instance.window.devicePixelRatio;

  static final textWidth = width * 0.003;

  static final lightTheme = ThemeData(
    primaryColor: const Color(0xffed6e3a),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xffed6e3a),
          ),
          fixedSize: MaterialStateProperty.all<Size>(
            Size(width, (height * 0.05)),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
            color: Colors.white,
            fontSize: 16 * textWidth,
          ))),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 16 * textWidth,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        color: const Color(0xffdbcdb5),
        fontSize: 16 * textWidth,
      ),
      //sign Up and sign In text colors
      titleSmall: TextStyle(
        color: const Color(0xff6c9e4f),
        fontSize: 14 * textWidth,
      ),
      //What to cook today ? color
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 30 * textWidth,
        fontWeight: FontWeight.bold,
      ),
      //WTC color
      titleLarge: TextStyle(
        color: const Color(0xffed6e3a),
        fontSize: 60 * textWidth,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xffdbcdb5),
    ),
    colorScheme: const ColorScheme.light(
      //bottom color for sign up page
      primaryContainer: Color(0xffe0e0e0),
      //that is for background of the chef and post card
      secondaryContainer: Color(0xffeeeeee),
      //that color is for bottom of the post and chef picture color.
      onPrimaryContainer: Colors.white,
    ),
  );

  /*static final lightTheme = ThemeData(
    primaryColor: const Color(0xffed6e3a),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xffed6e3a),
        ),
      ),
    ),
    textTheme: TextTheme(
      labelMedium: TextStyle(
        color: Color(0xffdbcdb5),
        fontSize: 16 * MediaQuery.of(buildContext).textScaleFactor,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 60,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xffdbcdb5),
    ),
    colorScheme: const ColorScheme.light(
      primaryContainer: Color(0xff6c9e4f),
      secondaryContainer: Color(0xff5e3c2c),
    ),
  );*/

  static final darkTheme = ThemeData();
}
