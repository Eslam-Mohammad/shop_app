import 'package:flutter/material.dart';

String? token;
ThemeMode appMode = ThemeMode.light;

const String englishLanguageCode = 'en';
const String arabicLanguageCode = 'ar';
String? currentLanguageCode ;

final ColorScheme colorScheme = ColorScheme.light(
  primary: Color(0xFF5D1049),
  onPrimaryFixedVariant: Color(0xFF5D1049),
  secondary: Color(0xFFE30425),
  onSecondaryFixedVariant: Color(0xFFE30425),
  surface: Color(0xFFFFFFFF),

  error: Color(0xFFB00020),
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFFFFFFFF),
  onSurface:Color(0xFF000000),

  onError: Color(0xFFFD9726),
  brightness: Brightness.light,
);


ThemeData darkTheme =ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepOrange,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.black,

  ),
  scaffoldBackgroundColor: Colors.grey[400],
  appBarTheme:  AppBarTheme(
    titleTextStyle:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:Colors.white,
        fontFamily: 'Playwrite'),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    backgroundColor: Colors.grey,
    elevation: 0.0,
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  listTileTheme: ListTileThemeData(iconColor: Colors.black),
);