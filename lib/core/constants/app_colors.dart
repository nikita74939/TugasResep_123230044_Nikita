import 'package:flutter/material.dart';

class AppColors {
  // primary color — warm amber yang lebih dalam & sophisticated
  static const Color primary = Color(0xFFE8913A);
  static const Color primaryDark = Color(0xFFC97428);

  // Warna latar belakang — off-white bersih
  static const Color background = Color(0xFFF9F6F2);
  static const Color surface = Color(0xFFFFFFFF);

  // Warna teks
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textHint = Color(0xFFBBBBBB);

  // Warna favorit
  static const Color favorite = Color(0xFFD94040);
  static const Color favoriteLight = Color(0xFFFFF0F0);

  // Warna tambahan
  static const Color divider = Color(0xFFF0EDE8);
  static const Color cardShadow = Color(0x12000000);
  static const Color shimmer = Color(0xFFECE9E4);

  // ThemeData lengkap agar bisa dipakai di MaterialApp
  static ThemeData get theme => ThemeData(
        primaryColor: primary,
        scaffoldBackgroundColor: background,
        fontFamily: 'Nunito',
        colorScheme: const ColorScheme.light(
          primary: primary,
          secondary: primaryDark,
          surface: surface,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: surface,
          foregroundColor: textPrimary,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontFamily: 'Nunito',
            color: textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
          iconTheme: IconThemeData(color: textPrimary),
          surfaceTintColor: Colors.transparent,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: primary,
          unselectedItemColor: textHint,
          backgroundColor: surface,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF5F2EE),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: const BorderSide(color: primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: const BorderSide(color: favorite, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: const BorderSide(color: favorite, width: 1.5),
          ),
          hintStyle: const TextStyle(
            color: textHint,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w400,
          ),
        ),
        cardTheme: CardThemeData(
          color: surface,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          shadowColor: cardShadow,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Nunito',
            color: textPrimary,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Nunito',
            color: textSecondary,
          ),
        ),
        useMaterial3: false,
      );
}