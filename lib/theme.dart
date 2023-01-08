import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoFastaAppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.grey,
      iconTheme: const IconThemeData(color: Color(0xFF03608F)),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF03608F)),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            )
          ),
          
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF006094)),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(
              color: Color(0xFF111111),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(
              color: Colors.black26,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(
              color: Colors.black26,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(19)),
            borderSide: BorderSide(
              color: Colors.black26,
            ),
          )
        ),
      dividerColor: const Color(0xFF03608F),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.lightBlue.shade600
      ),
      unselectedWidgetColor: const Color(0x50333333),
      shadowColor: Colors.grey.withOpacity(.3),
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
          color: Color.fromARGB(170, 35, 35, 35),
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
