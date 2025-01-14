import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._(); //private constructor yeni nesne oluşturmayı engeller

  static ThemeData get lightTheme => ThemeData(
        fontFamily: "Inter",
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Color(0xff42B4CA),
          secondary: Color(0xffD5E9ED),
          surface: Colors.white,
          onSurface: Color(0xff414A4C),
          error: Color(0xffEA7979),
          tertiary: Color(0xffB5C4C7),
        ),

        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: const Color(0xff42B4CA),
          ),
        ),
      );
}
