import 'package:flutter/material.dart';

import 'glass_container.dart';

class GlassButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double blur;
  final double opacity;
  final IconData? icon;
  final double iconSize;
  final Color iconColor;

  const GlassButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.color = const Color(0xFFFFFFFF),
    this.blur = 10.0,
    this.opacity = 0.2,
    this.icon,
    this.iconSize = 18.0,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: GlassContainer(
        borderRadius: borderRadius,
        padding: padding,
        color: color,
        blur: blur,
        opacity: opacity,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: iconSize, color: iconColor),
                const SizedBox(width: 8),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }
}
