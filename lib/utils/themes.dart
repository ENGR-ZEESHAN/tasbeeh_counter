import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static var primarySwatch = const Color(0xFF00A99D);
  static Color primaryContrast = const Color(0x55000022);
  static Color cream = const Color(0XFFEFEFEF);

  static ThemeData lightTheme() => ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: GoogleFonts.poppinsTextTheme(),
     );
  static ThemeData darkTheme() => ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        textTheme: GoogleFonts.poppinsTextTheme(),
      );
}
