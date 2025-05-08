import 'package:flutter/material.dart';

class AppTheme {
  // Warna Utama
  static const Color _primaryColorLight = Color(0xFF1E88E5); // Biru Muda
  static const Color _primaryColorDark = Color(0xFF64B5F6); // Biru Muda Terang

  // Warna Aksen
  static const Color _accentColorLight = Color(0xFF26A69A); // Hijau Teal
  static const Color _accentColorDark = Color(0xFF4DB6AC); // Hijau Teal Terang

  // Background
  static const Color _backgroundLight = Colors.white;
  static const Color _backgroundDark = Color(0xFF121212);

  // Surface
  static const Color _surfaceLight = Color(0xFFF5F5F5);
  static const Color _surfaceDark = Color(0xFF1E1E1E);

  // Error
  static const Color _errorLight = Color(0xFFE53935);
  static const Color _errorDark = Color(0xFFEF5350);

  // Text
  static const Color _textPrimaryLight = Color(0xFF212121);
  static const Color _textSecondaryLight = Color(0xFF757575);
  static const Color _textPrimaryDark = Color(0xFFE0E0E0);
  static const Color _textSecondaryDark = Color(0xFFB0B0B0);

  // Success dan Attendance Colors
  static const Color _presentColor = Color(0xFF43A047); // Hijau
  static const Color _absentColor = Color(0xFFE53935); // Merah
  static const Color _lateColor = Color(0xFFFFA000); // Amber
  static const Color _leaveColor = Color(0xFF8E24AA); // Ungu

  // Card Elevation
  static const double _cardElevation = 2.0;

  // Radius
  static const double _borderRadius = 12.0;
  static const double _buttonRadius = 8.0;
  static const double _inputRadius = 8.0;

  // Font Family
  static const String _fontFamily = 'Poppins';

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: _primaryColorLight,
    colorScheme: ColorScheme.light(
      primary: _primaryColorLight,
      onPrimary: Colors.white,
      secondary: _accentColorLight,
      onSecondary: Colors.white,
      background: _backgroundLight,
      onBackground: _textPrimaryLight,
      surface: _surfaceLight,
      onSurface: _textPrimaryLight,
      error: _errorLight,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: _backgroundLight,
    fontFamily: _fontFamily,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: _primaryColorLight,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamily,
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: _backgroundLight,
      elevation: _cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),

    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColorLight,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          fontFamily: _fontFamily,
        ),
      ),
    ),

    // OutlinedButton Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryColorLight,
        side: BorderSide(color: _primaryColorLight, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          fontFamily: _fontFamily,
        ),
      ),
    ),

    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryColorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          fontFamily: _fontFamily,
        ),
      ),
    ),

    // IconButton Theme
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: _primaryColorLight,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
      ),
    ),

    // FloatingActionButton Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _primaryColorLight,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
    ),

    // InputDecoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _surfaceLight,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide(color: _primaryColorLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide(color: _errorLight, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide(color: _errorLight, width: 2),
      ),
      labelStyle: TextStyle(
        color: _textSecondaryLight,
        fontSize: 14,
        fontFamily: _fontFamily,
      ),
      hintStyle: TextStyle(
        color: _textSecondaryLight.withOpacity(0.7),
        fontSize: 14,
        fontFamily: _fontFamily,
      ),
      errorStyle: TextStyle(
        color: _errorLight,
        fontSize: 12,
        fontFamily: _fontFamily,
      ),
    ),

    // CheckBox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _primaryColorLight;
        }
        return null;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),

    // Radio Button Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _primaryColorLight;
        }
        return null;
      }),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _primaryColorLight;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _primaryColorLight.withOpacity(0.5);
        }
        return null;
      }),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _backgroundLight,
      selectedItemColor: _primaryColorLight,
      unselectedItemColor: _textSecondaryLight,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: _fontFamily,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: _fontFamily,
      ),
    ),

    // TabBar Theme
    tabBarTheme: TabBarTheme(
      labelColor: _primaryColorLight,
      unselectedLabelColor: _textSecondaryLight,
      indicatorColor: _primaryColorLight,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamily,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: _fontFamily,
      ),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: _textSecondaryLight.withOpacity(0.2),
      thickness: 1,
      space: 1,
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: _backgroundLight,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      titleTextStyle: TextStyle(
        color: _textPrimaryLight,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamily,
      ),
      contentTextStyle: TextStyle(
        color: _textPrimaryLight,
        fontSize: 16,
        fontFamily: _fontFamily,
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: _surfaceLight,
      disabledColor: _surfaceLight.withOpacity(0.5),
      selectedColor: _primaryColorLight,
      secondarySelectedColor: _primaryColorLight.withOpacity(0.8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      labelStyle: TextStyle(
        color: _textPrimaryLight,
        fontSize: 14,
        fontFamily: _fontFamily,
      ),
      secondaryLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: _fontFamily,
      ),
      brightness: Brightness.light,
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: _primaryColorLight,
      circularTrackColor: _primaryColorLight.withOpacity(0.2),
      linearTrackColor: _primaryColorLight.withOpacity(0.2),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: _textPrimaryLight,
        fontFamily: _fontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: _textPrimaryLight,
        fontFamily: _fontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: _textPrimaryLight,
        fontFamily: _fontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: _textPrimaryLight,
        fontFamily: _fontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _textPrimaryLight,
        fontFamily: _fontFamily,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: _textPrimaryLight,
        fontFamily: _fontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: _textPrimaryLight,
        fontFamily: _fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: _textPrimaryLight,
        fontFamily: _fontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: _textPrimaryLight,
        fontFamily: _fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: _textPrimaryLight,
        fontFamily: _fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: _textPrimaryLight,
        fontFamily: _fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: _textSecondaryLight,
        fontFamily: _fontFamily,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: _primaryColorLight,
        fontFamily: _fontFamily,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: _primaryColorLight,
        fontFamily: _fontFamily,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: _textSecondaryLight,
        fontFamily: _fontFamily,
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: _primaryColorDark,
    colorScheme: ColorScheme.dark(
      primary: _primaryColorDark,
      onPrimary: Colors.black,
      secondary: _accentColorDark,
      onSecondary: Colors.black,
      background: _backgroundDark,
      onBackground: _textPrimaryDark,
      surface: _surfaceDark,
      onSurface: _textPrimaryDark,
      error: _errorDark,
      onError: Colors.black,
    ),
    scaffoldBackgroundColor: _backgroundDark,
    fontFamily: _fontFamily,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: _surfaceDark,
      foregroundColor: _textPrimaryDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamily,
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: _surfaceDark,
      elevation: _cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),

    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColorDark,
        foregroundColor: Colors.black,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          fontFamily: _fontFamily,
        ),
      ),
    ),

    // OutlinedButton Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryColorDark,
        side: BorderSide(color: _primaryColorDark, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          fontFamily: _fontFamily,
        ),
      ),
    ),

    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryColorDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          fontFamily: _fontFamily,
        ),
      ),
    ),

    // IconButton Theme
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: _primaryColorDark,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
      ),
    ),

    // FloatingActionButton Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _primaryColorDark,
      foregroundColor: Colors.black,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _backgroundDark.withOpacity(0.8),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide(color: _primaryColorDark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide(color: _errorDark, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide(color: _errorDark, width: 2),
      ),
      labelStyle: TextStyle(
        color: _textSecondaryDark,
        fontSize: 14,
        fontFamily: _fontFamily,
      ),
      hintStyle: TextStyle(
        color: _textSecondaryDark.withOpacity(0.7),
        fontSize: 14,
        fontFamily: _fontFamily,
      ),
      errorStyle: TextStyle(
        color: _errorDark,
        fontSize: 12,
        fontFamily: _fontFamily,
      ),
    ),

    // CheckBox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _primaryColorDark;
        }
        return null;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),

    // Radio Button Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _primaryColorDark;
        }
        return null;
      }),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _primaryColorDark;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _primaryColorDark.withOpacity(0.5);
        }
        return null;
      }),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _surfaceDark,
      selectedItemColor: _primaryColorDark,
      unselectedItemColor: _textSecondaryDark,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: _fontFamily,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: _fontFamily,
      ),
    ),

    // TabBar Theme
    tabBarTheme: TabBarTheme(
      labelColor: _primaryColorDark,
      unselectedLabelColor: _textSecondaryDark,
      indicatorColor: _primaryColorDark,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamily,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: _fontFamily,
      ),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: _textSecondaryDark.withOpacity(0.2),
      thickness: 1,
      space: 1,
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: _surfaceDark,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      titleTextStyle: TextStyle(
        color: _textPrimaryDark,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamily,
      ),
      contentTextStyle: TextStyle(
        color: _textPrimaryDark,
        fontSize: 16,
        fontFamily: _fontFamily,
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: _backgroundDark,
      disabledColor: _backgroundDark.withOpacity(0.5),
      selectedColor: _primaryColorDark,
      secondarySelectedColor: _primaryColorDark.withOpacity(0.8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      labelStyle: TextStyle(
        color: _textPrimaryDark,
        fontSize: 14,
        fontFamily: _fontFamily,
      ),
      secondaryLabelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: _fontFamily,
      ),
      brightness: Brightness.dark,
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: _primaryColorDark,
      circularTrackColor: _primaryColorDark.withOpacity(0.2),
      linearTrackColor: _primaryColorDark.withOpacity(0.2),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: _textPrimaryDark,
        fontFamily: _fontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: _textPrimaryDark,
        fontFamily: _fontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: _textPrimaryDark,
        fontFamily: _fontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: _textPrimaryDark,
        fontFamily: _fontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _textPrimaryDark,
        fontFamily: _fontFamily,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: _textPrimaryDark,
        fontFamily: _fontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: _textPrimaryDark,
        fontFamily: _fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: _textPrimaryDark,
        fontFamily: _fontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: _textPrimaryDark,
        fontFamily: _fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: _textPrimaryDark,
        fontFamily: _fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: _textPrimaryDark,
        fontFamily: _fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: _textSecondaryDark,
        fontFamily: _fontFamily,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: _primaryColorDark,
        fontFamily: _fontFamily,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: _primaryColorDark,
        fontFamily: _fontFamily,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: _textSecondaryDark,
        fontFamily: _fontFamily,
      ),
    ),
  );

  // Custom Attendance Status Colors
  static Color getAttendanceStatusColor(String status,
      {bool isDarkMode = false}) {
    switch (status.toLowerCase()) {
      case 'present':
      case 'hadir':
        return _presentColor;
      case 'absent':
      case 'tidak hadir':
        return _absentColor;
      case 'late':
      case 'terlambat':
        return _lateColor;
      case 'leave':
      case 'izin':
        return _leaveColor;
      default:
        return isDarkMode ? _primaryColorDark : _primaryColorLight;
    }
  }
}
