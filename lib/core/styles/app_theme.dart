import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

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
