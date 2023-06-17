import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppFonts {
// Font sizes used in the app
// ==========================

// 12px on mobile devices, 14px on desktop
  static TextStyle bodyStyle = GoogleFonts.roboto(
    fontSize: 20,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.normal,
  );

  // 14px on mobile devices, 16px on desktop
  static TextStyle titleStyle = GoogleFonts.roboto(
    fontSize: 26,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.bold,
  );

// 18px on mobile devices, 24px on desktop
  static TextStyle subHeadingStyle = GoogleFonts.roboto(
    fontSize: 35,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.bold,
  );
// 18px on mobile devices, 24px on desktop
  static TextStyle headingStyle = GoogleFonts.roboto(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );

  // 8px on mobile devices, 10px on desktop
  static TextStyle smallBody = GoogleFonts.roboto(
    fontSize: 16,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.normal,
  );
}
