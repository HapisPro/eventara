import 'package:flutter/material.dart';

enum AppColor {
  orange("Orange", Colors.orange),
  blue("Blue", Color(0xFF0077B6)),
  backgroundColor("BackColor", Color(0xFFF4F4F9));

  const AppColor(this.name, this.color);
  final String name;
  final Color color;
}
