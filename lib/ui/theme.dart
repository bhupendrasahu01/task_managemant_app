import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

const color = const Color(0xFFB74093);
const Color bluishClr = Color(0xFF2E52D7);
const Color darkgray = Color(0xFF2E52D7);
const Color pinkClr = Color(0xFFD2149C);
const Color greenClr = Color(0xFF39D72E);
const Color yellowClr = Color(0xFFD7C02E);
const Color backgroudClr = Color(0xFFFFFFFF);
const Color grayClr = Color(0xFFE5DFDF);
const primaryClr = bluishClr;

TextStyle get subHeadingStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
}

TextStyle get dropDownStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold)));
}

TextStyle get headingStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)));
}

TextStyle get titleStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)));
}

TextStyle get subTitleStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)));
}

TextStyle get DashboardTextStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600)));
}

TextStyle get subDashboardTextStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey)));
}

TextStyle get dateTimeTextStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey)));
}

TextStyle get todayTextStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  )));
}

TextStyle get seeAllTextStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey)));
}

TextStyle get titleTextStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  )));
}

TextStyle get formfieldTitleTextStyle {
  return (GoogleFonts.lato(
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w900,
      )));
}