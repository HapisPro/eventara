import 'package:flutter/material.dart';
enum AppColor {
  // Primary Colors
  primary("Primary", Color(0xFF0097C5)),
  primaryLight("Primary Light", Color(0xFF48CAE4)),
  primaryDark("Primary Dark", Color(0xFF023E8A)),
  
  // Accent Colors
  accent("Accent", Color(0xFFFF6B35)),
  accentLight("Accent Light", Color(0xFFFF8C61)),
  
  // Background Colors
  backgroundLight("Background Light", Color(0xFFF8F9FA)),
  backgroundDark("Background Dark", Color(0xFF121212)),
  surfaceLight("Surface Light", Colors.white),
  surfaceDark("Surface Dark", Color(0xFF1E1E1E)),
  
  // Text Colors
  textPrimaryLight("Text Primary Light", Color(0xFF212529)),
  textSecondaryLight("Text Secondary Light", Color(0xFF6C757D)),
  textPrimaryDark("Text Primary Dark", Color(0xFFE9ECEF)),
  textSecondaryDark("Text Secondary Dark", Color(0xFFADB5BD)),
  
  // Success & Error
  success("Success", Color(0xFF06D6A0)),
  error("Error", Color(0xFFEF476F));

  const AppColor(this.name, this.color);
  final String name;
  final Color color;
}
