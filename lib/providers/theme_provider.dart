import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.lightPrimary,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1E1E1E),
      secondary: Color(0xFF424242),
      tertiary: Color(0xFFFF6B6B),
    ),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 16),
      headlineMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );

  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: AppColors.darkPrimary,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF121212),
      secondary: Color(0xFF2C2C2C),
      tertiary: Color(0xFF4ECDC4),
    ),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 16),
      headlineMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );

  ThemeProvider() {
    _load();
  }

  void toggleTheme(ThemeMode mode) async {
    themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', mode.toString());
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString('themeMode');
    if (s != null) {
      if (s.contains('light')) themeMode = ThemeMode.light;
      else if (s.contains('dark')) themeMode = ThemeMode.dark;
      else themeMode = ThemeMode.system;
      notifyListeners();
    }
  }
}
