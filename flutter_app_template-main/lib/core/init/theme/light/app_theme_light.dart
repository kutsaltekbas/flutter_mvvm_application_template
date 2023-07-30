import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_theme.dart';

class AppThemeLight extends AppTheme {
  static AppThemeLight? _instance;
  static AppThemeLight get instance => _instance ??= AppThemeLight._init();

  AppThemeLight._init();

  @override
  ThemeData get theme => ThemeData(
        colorScheme: _colorSchemeLight,
        textTheme: _textThemeLight,
        scaffoldBackgroundColor: _colorSchemeLight.background,
        appBarTheme: _appBarTheme,
        inputDecorationTheme: _inputDecorationTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        timePickerTheme: _timePickerTheme,
      );
  /* Color Palette For The App. */

  ColorScheme get _colorSchemeLight => const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xffffffff), //
        primaryContainer: Color(0xffB56576), //
        secondary: Color(0xff6D597A), //
        onSecondary: Color(0xffE56B6F),
        onPrimary: Color(0xffEAAC8B), //
        background: Color(0xff355070), //
        onBackground: Color(0xff0F1729), //
        error: Color(0xffff5656), //
        errorContainer: Color(0xFFFFA41D), //
        onError: Color(0xffffffff),
        surface: Color(0xffE6EBF3),
        onSurface: Color(0xff596372), //
        tertiary: Color(0xff127255), //
        tertiaryContainer: Color(0xffBB79E5), //
        onTertiary: Color(0xffA1ABBC), //
        onSurfaceVariant: Color(0xff6F7490), //
        secondaryContainer: Color(0xFFE5E5E5), //
        onTertiaryContainer: Color(0xffDADADC), //
        onErrorContainer: Color(0xffffcc86), //
        inversePrimary: Color(0xff40a3ff),
        inverseSurface: Color(0xffadd328),
        onPrimaryContainer: Color(0xff024786),
        onInverseSurface: Color(0xffececec),
      );

  TimePickerThemeData get _timePickerTheme =>
      TimePickerThemeData(backgroundColor: _colorSchemeLight.onSecondary);
  /* Text Theme For The App */

  TextTheme get _textThemeLight => TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          color: _colorSchemeLight.onBackground,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 28.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.5,
          color: _colorSchemeLight.onBackground,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 24.sp,
          fontWeight: FontWeight.w400,
          color: _colorSchemeLight.onBackground,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: _colorSchemeLight.onBackground,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: _colorSchemeLight.onBackground,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: _colorSchemeLight.onBackground,
        ),
        labelLarge: GoogleFonts.poppins(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
          color: _colorSchemeLight.onBackground,
        ),
        labelMedium: GoogleFonts.poppins(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: _colorSchemeLight.onBackground,
        ),
        labelSmall: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: _colorSchemeLight.onBackground,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: _colorSchemeLight.onBackground,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: _colorSchemeLight.onBackground,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: _colorSchemeLight.onBackground,
        ),
        titleSmall: GoogleFonts.poppins(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: _colorSchemeLight.onBackground,
        ),
      );

  /* Appbar Theme */

  AppBarTheme get _appBarTheme => AppBarTheme(
        backgroundColor: _colorSchemeLight.background,
        titleTextStyle: _textThemeLight.bodyMedium!
            .copyWith(color: _colorSchemeLight.onSurface),
      );

  /* Text Field Theme */

  InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        focusColor: _colorSchemeLight.secondaryContainer,
        labelStyle: _textThemeLight.labelLarge!
            .copyWith(color: _colorSchemeLight.onBackground.withOpacity(0.4)),
        floatingLabelStyle: _textThemeLight.labelLarge!
            .copyWith(color: _colorSchemeLight.onBackground.withOpacity(0.4)),
        hintStyle: _textThemeLight.labelLarge!
            .copyWith(color: _colorSchemeLight.onBackground.withOpacity(0.3)),
        helperStyle: _textThemeLight.titleSmall!
            .copyWith(color: _colorSchemeLight.primary),
        fillColor: _colorSchemeLight.secondaryContainer,
        prefixIconColor: _colorSchemeLight.onBackground.withOpacity(0.4),
        errorStyle: _textThemeLight.titleSmall!
            .copyWith(color: _colorSchemeLight.error),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _colorSchemeLight.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _colorSchemeLight.error),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 0,
          borderSide: BorderSide(color: _colorSchemeLight.surface),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _colorSchemeLight.surface),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 0,
          borderSide: BorderSide(color: _colorSchemeLight.primary),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _colorSchemeLight.surface),
        ),
      );

  /* Elevated Button Theme */

  ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: _colorSchemeLight.onPrimary,
          backgroundColor: _colorSchemeLight.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 3,
          textStyle: _textThemeLight.labelSmall,
        ),
      );
  OutlinedButtonThemeData get _outlinedButtonTheme => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _colorSchemeLight.onBackground,
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(width: 2, color: _colorSchemeLight.primary),
          textStyle: _textThemeLight.labelSmall,
        ),
      );
}
