import 'package:flutter/material.dart';

import 'glass_container.dart';

class GlassDropdown extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onTap;
  final double blur;
  final Color color;
  final double opacity;

  const GlassDropdown({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.onTap,
    this.blur = 10.0,
    this.color = const Color(0xFFFFFFFF),
    this.opacity = 0.1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      borderRadius: 20,
      color: color,
      opacity: opacity,
      blur: blur,
      child: TextFormField(
        controller: controller,
        readOnly: true,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText.isEmpty ? null : labelText,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.white, size: 25),
        ),
        onTap: onTap,
      ),
    );
  }
}
