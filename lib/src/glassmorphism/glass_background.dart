import 'dart:math';

import 'package:flutter/material.dart';

class GlassBackground extends StatefulWidget {
  final Widget child;
  final bool animate;
  final List<Color>? colors;

  // Predefined company colors
  static const List<Color> savoria = [Color(0xFFEC1B30), Color(0xFFD22737)];
  static const List<Color> gonusa = [Color(0xFF382E82), Color(0xFFEF9E00)];
  static const List<Color> gda = [Color(0xFF00A3DE), Color(0xFF203A85)];
  static const List<Color> ptb = [Color(0xFFFAB726), Color(0xFFE72F2A)];
  static const List<Color> skp = [Color(0xFF57311F), Color(0xFF0F6445)];
  static const List<Color> skr = [Color(0xFF004B8B), Color(0xFF00884D), Color(0xFF7AC810)];
  static const List<Color> light = [Colors.white, Color(0xFFF5F6FC)];

  const GlassBackground({
    Key? key,
    required this.child,
    this.animate = true,
    this.colors,
  }) : super(key: key);

  @override
  State<GlassBackground> createState() => _GlassBackgroundState();
}

class _GlassBackgroundState extends State<GlassBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );

    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant GlassBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = widget.colors ?? const [
      Color.fromARGB(255, 0, 11, 71),
      Color.fromARGB(255, 68, 0, 80),
    ];

    // Determine a glow color based on the first gradient color
    final glowColor = gradientColors.first.withOpacity(0.4);

    return Stack(
      children: [
        // Base dark gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // Animated circles
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1 +
                      (sin(_controller.value * 2 * pi) * 60),
                  left: MediaQuery.of(context).size.width * 0.1 +
                      (cos(_controller.value * 2 * pi) * 60),
                  child: _buildGlowingCircle(glowColor, 200),
                ),
              ],
            );
          },
        ),

        widget.child,
      ],
    );
  }

  Widget _buildGlowingCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.6),
      ),
    );
  }
}
