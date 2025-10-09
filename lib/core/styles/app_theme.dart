import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.orange.color,
        primary: AppColor.orange.color,
        secondary: AppColor.blue.color,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColor.backgroundColor.color,

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColor.orange.color,
        unselectedItemColor: Colors.black,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
