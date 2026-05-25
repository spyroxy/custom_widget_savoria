import 'package:flutter/material.dart';

import 'glass_container.dart';

class GlassPrefixTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final Color prefixColor;
  final double prefixWidth;
  final double borderRadius;
  final double blur;
  final double opacity;
  final bool obscureText;
  final Color color;

  const GlassPrefixTextField({
    Key? key,
    this.controller,
    this.labelText = 'Label',
    this.hintText = 'Enter text...',
    this.prefixIcon = Icons.calendar_month,
    this.prefixColor = const Color(0xFFE51C23),
    this.prefixWidth = 60.0,
    this.borderRadius = 12.0,
    this.blur = 10.0,
    this.opacity = 0.08,
    this.obscureText = false,
    this.color = const Color(0xFFFFFFFF),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText.isNotEmpty) ...[
          Text(
            labelText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        GlassContainer(
          borderRadius: borderRadius,
          blur: blur,
          color: color,
          opacity: opacity,
          child: Row(
            children: [
              Container(
                width: prefixWidth,
                height: 54,
                decoration: BoxDecoration(
                  color: prefixColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    bottomLeft: Radius.circular(borderRadius),
                  ),
                ),
                child: Center(
                  child: Icon(
                    prefixIcon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: controller,
                    obscureText: obscureText,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
