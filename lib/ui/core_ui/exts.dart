import 'package:flutter/material.dart';

extension E on Widget {
  Widget sliverToBoxAdapter() {
    return SliverToBoxAdapter(child: this);
  }
}

extension TasksColors on Colors {
  static const Color mainBlack = Color(0xFF2c2430);
  static const Color iconWhite = Color(0xFF968B9C);
  static const Color newTask = Color(0xFF76687D);
  static const Color description_text = Colors.white70;
  static const Color toast_color = Color(0xFF4C4052);
  static const Color textColor = Color(0xFFD1CCD3);
}
