import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoFastaAppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.teal,
      iconTheme: IconThemeData(color: Color(0xFF03608F)),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF03608F)),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFC4C4C4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      dividerColor: Colors.transparent,
      unselectedWidgetColor: const Color(0x50333333),
      shadowColor: const Color(0xFF4C4C4C).withOpacity(0.5),
      backgroundColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF03608F),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white30),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'Poppins',
      textTheme: TextTheme(
        headline1: GoogleFonts.poppins(
          color: const Color(0xFFFFFFFF),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headline2: GoogleFonts.poppins(
          color: const Color(0xFF111111),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headline3: GoogleFonts.poppins(
          color: const Color(0xFF111111),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        headline4: GoogleFonts.poppins(
          color: const Color(0xFF111111),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        headline5: GoogleFonts.poppins(
          color: const Color(0xFF111111),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        headline6: GoogleFonts.poppins(
          color: const Color(0x6B232323),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        bodyText1: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyText2: GoogleFonts.poppins(
          color: const Color(0xFF111111),
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
        
      ),
      listTileTheme: ListTileThemeData(
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.symmetric(horizontal: 16)
      )
    );
  }
}

TextStyle textStyle(double size, Color color, FontWeight fw) {
  return GoogleFonts.poppins(fontSize: size, color: color, fontWeight: fw);
}
