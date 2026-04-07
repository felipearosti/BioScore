import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_screen.dart';

void main() {
  runApp(const BioScoreApp());
}

class BioScoreApp extends StatelessWidget {
  const BioScoreApp({super.key});

  static const Color _primaryColor = Color(0xFF2C3E50);
  static const Color _accentColor = Color(0xFF4DB6AC);
  static const Color _backgroundColor = Color(0xFFF0F4F8);
  static const Color _surfaceColor = Color(0xFFD1D9E6);
  static const Color _textColor = Color(0xFF2C3E50);
  static const Color _alertColor = Color(0xFFFF8A65);

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme();

    return MaterialApp(
      title: 'BioScore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: _primaryColor,
          secondary: _accentColor,
          surface: _surfaceColor,
          error: _alertColor,
          onPrimary: Colors.white,
          onSecondary: _textColor,
          onSurface: _textColor,
          onError: _textColor,
        ),
        textTheme: textTheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: _backgroundColor,
          foregroundColor: _primaryColor,
          elevation: 0,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFDDE2E8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: _accentColor, width: 1.5),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _accentColor,
            foregroundColor: _primaryColor,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
