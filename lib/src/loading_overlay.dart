import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final bool isBackground;
  final double opacity;
  final Widget widgetCenter;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    required this.isBackground,
    this.opacity = 0,
    required this.widgetCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,

          child: IgnorePointer(
            ignoring: opacity == 0,
            child: Container(
              color: isBackground
                  ? Colors.white
                  : Colors.black.withOpacity(0.4),
              child: Center(
                child: widgetCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


