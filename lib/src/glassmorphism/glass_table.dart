import 'package:flutter/material.dart';
import 'glass_container.dart';

class GlassTable extends StatelessWidget {
  final int columnsCount;
  final int rowsCount;
  final double borderRadius;
  final double blur;
  final Color color;
  final double opacity;
  final Color textColor;

  const GlassTable({
    Key? key,
    this.columnsCount = 3,
    this.rowsCount = 3,
    this.borderRadius = 16.0,
    this.blur = 10.0,
    this.color = Colors.white,
    this.opacity = 0.2,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cols = columnsCount.clamp(1, 10);
    final rows = rowsCount.clamp(1, 20);

    return GlassContainer(
      borderRadius: borderRadius,
      blur: blur,
      color: color,
      opacity: opacity,
      padding: const EdgeInsets.all(12),
      child: Table(
        border: TableBorder(
          horizontalInside: BorderSide(
            color: textColor.withOpacity(0.15),
            width: 1,
          ),
          verticalInside: BorderSide(
            color: textColor.withOpacity(0.1),
            width: 0.5,
          ),
        ),
        children: [
          // Header row
          TableRow(
            children: List.generate(cols, (colIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Text(
                  'Col ${colIndex + 1}',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }),
          ),
          // Data rows
          ...List.generate(rows, (rowIndex) {
            return TableRow(
              children: List.generate(cols, (colIndex) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: Text(
                    'R${rowIndex + 1} C${colIndex + 1}',
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }
}
