import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';

class SwitchTexts {
  static TextStyle titleScreen(Color color) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 30,
      letterSpacing: -0.75,
    );
  }

  static TextStyle titleSection(Color color) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 18,
      letterSpacing: -0.18,
    );
  }

  static TextStyle titleSubsection(Color color) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 28,
      letterSpacing: -1.25,
    );
  }

  static TextStyle titleBody(Color color) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 18,
      letterSpacing: -1,
    );
  }

  static TextStyle titleGroup(Color color) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 14,
      letterSpacing: -1.5,
    );
  }

  static TextStyle bodyLarge(Color color) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 16,
      letterSpacing: -0.5,
    );
  }

  static TextStyle bodyLargeBold(Color color) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    );
  }

  static TextStyle bodyDefault(Color color) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 22,
      letterSpacing: 1,
    );
  }

  static TextStyle bodyDefaultBold(Color color) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5,
    );
  }
}
