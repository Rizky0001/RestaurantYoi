import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFFFFFFFF);
final Color primaryLightColor = Color(0xFFFFFFFF);
final Color primaryDarkColor = Color(0xFF585858);
final Color secondaryColor = Color(0xFFF34040);
final Color secondaryLightColor = Color(0xFFE07265);
final Color secondaryDarkColor = Color(0xFFBA0E27);
final Color primaryTextColor = Color(0xFF3E6ED0);
final Color secondaryTextColor = Color(0xFF000000);
final Color thirdTextColor = Color(0xFFBABABA);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(
      fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.poppins(
      fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.poppins(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.poppins(
      fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.poppins(
      fontSize: 23, fontWeight: FontWeight.bold, color: secondaryColor),
  headline6: GoogleFonts.poppins(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

final TextTheme myTextThemeDark = TextTheme(
  headline1: GoogleFonts.poppins(
      fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.poppins(
      fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.poppins(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.poppins(
      fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.poppins(
      fontSize: 23, fontWeight: FontWeight.bold, color: secondaryColor),
  headline6: GoogleFonts.poppins(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Color(0xFF616161)),
  subtitle1: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: Color(0xFF616161)),
  subtitle2: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Color(0xFF616161)),
  bodyText1: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xFF616161)),
  bodyText2: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Color(0xFF616161)),
  button: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: Color(0xFF616161)),
  caption: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: Color(0xFF616161)),
  overline: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: Color(0xFF616161)),
);

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: AppBarTheme(
    elevation: 0, toolbarTextStyle: myTextTheme.apply(bodyColor: primaryTextColor).bodyText2, titleTextStyle: myTextTheme.apply(bodyColor: primaryTextColor).headline6,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: secondaryColor,
    unselectedItemColor: Colors.black54,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: secondaryColor,
      textStyle: TextStyle(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
  chipTheme: ChipThemeData(
    labelStyle: TextStyle(
      color: secondaryColor,
    ),
    selectedColor: secondaryColor,
    disabledColor: primaryDarkColor,
    selectedShadowColor: Color(0xFF616161),
    secondarySelectedColor: secondaryColor,
    secondaryLabelStyle: TextStyle(
      color: primaryColor,
    ),
    brightness: Brightness.light,
    backgroundColor: Color(0xFFFFE9E9),
    padding: EdgeInsets.all(2),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: primaryDarkColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextThemeDark,
  appBarTheme: AppBarTheme(
    elevation: 0, toolbarTextStyle: myTextTheme.apply(bodyColor: secondaryColor).bodyText2, titleTextStyle: myTextTheme.apply(bodyColor: secondaryColor).headline6,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: secondaryColor,
      textStyle: TextStyle(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryDarkColor),
);
