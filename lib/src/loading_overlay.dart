import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingOverlay extends StatefulWidget {
  final bool isLoading;
  final Widget child;
  final bool isBackground;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    required this.isBackground,
  });

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();

    /// penting! set nilai awal
    opacity = widget.isLoading ? 1 : 0;
  }

  @override
  void didUpdateWidget(covariant LoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isLoading != oldWidget.isLoading) {
      setState(() {
        opacity = widget.isLoading ? 1 : 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,

        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,

          child: IgnorePointer(
            ignoring: opacity == 0,
            child: Container(
              color: widget.isBackground
                  ? Colors.white
                  : Colors.black.withOpacity(0.4),
              child: Center(
                child: Lottie.asset(
                  "assets/loading_box.json",
                  width: 160,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
