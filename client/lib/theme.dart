import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // *****************
  // Static colors
  // *****************
  static final Color _lightPrimaryColor = Colors.blueGrey.shade50;
  static final Color _lightPrimaryVariantColor = Colors.blueGrey.shade800;
  static final Color _lightOnPrimaryColor = Colors.blueGrey.shade200;
  static const Color _lightTextColorPrimary = Colors.black;
  static const Color _appbarColorLight = Colors.blue;

  static final Color _darkPrimaryColor = Colors.blueGrey.shade900;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
  static const Color _darkTextColorPrimary = Colors.white;
  static final Color _appbarColorDark = Colors.blueGrey.shade800;

  static const Color _iconColor = Colors.white;
  static const Color _accentColor = Color.fromRGBO(74, 217, 217, 1);

  // *****************
  // Text Styles
  // *****************
  static const TextStyle _lightHeadingText = TextStyle(
    color: _lightTextColorPrimary,
    fontFamily: "Rubik",
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _lightBodyText = TextStyle(
    color: _lightTextColorPrimary,
    fontFamily: "Rubik",
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightHeadingText,
    bodyLarge: _lightBodyText,
  );

  static final TextStyle _darkHeadingText =
      _lightHeadingText.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkBodyText =
      _lightBodyText.copyWith(color: _darkTextColorPrimary);

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: _darkHeadingText,
    bodyLarge: _darkBodyText,
  );

  // *****************
  // Button Styles
  // *****************
  static final ButtonStyle _lightElevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF4AD9D9),
    foregroundColor: _darkTextColorPrimary,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static final ButtonStyle _darkElevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF4AD9D9),
    foregroundColor: _darkTextColorPrimary,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  // *****************
  // RadioButton Styles
  // *****************
  static final RadioThemeData _lightRadioTheme = RadioThemeData(
    fillColor: WidgetStateProperty.all<Color>(Colors.blueGrey.shade800),
    overlayColor: WidgetStateProperty.all<Color>(Colors.blueGrey.shade200),
  );

  static final RadioThemeData _darkRadioTheme = RadioThemeData(
    fillColor: WidgetStateProperty.all<Color>(Colors.blueGrey.shade300),
    overlayColor: WidgetStateProperty.all<Color>(Colors.blueGrey.shade600),
  );

  // *****************
  // ThemeData light/dark
  // *****************
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryColor,
    appBarTheme: const AppBarTheme(
      color: _appbarColorLight,
      iconTheme: IconThemeData(color: _iconColor),
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      onPrimary: _lightOnPrimaryColor,
      secondary: const Color(0xFF4AD9D9),
      primaryContainer: _lightPrimaryVariantColor,
    ),
    textTheme: _lightTextTheme,
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: _lightElevatedButtonStyle),
    radioTheme: _lightRadioTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryColor,
    appBarTheme: AppBarTheme(
      color: _appbarColorDark,
      iconTheme: const IconThemeData(color: _iconColor),
    ),
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _accentColor,
      onPrimary: _darkOnPrimaryColor,
      primaryContainer: _darkPrimaryVariantColor,
    ),
    textTheme: _darkTextTheme,
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: _darkElevatedButtonStyle),
    radioTheme: _darkRadioTheme,
  );
}
