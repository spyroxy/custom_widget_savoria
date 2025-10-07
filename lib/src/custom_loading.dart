import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const CustomLoading({
    Key? key,
    this.size = 16,          // default ukuran kecil
    this.strokeWidth = 4,    // ketebalan garis
    this.color,              // warna opsional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
