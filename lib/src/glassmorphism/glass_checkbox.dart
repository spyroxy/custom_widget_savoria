import 'package:flutter/material.dart';

import 'glass_container.dart';

class GlassCheckbox extends StatefulWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final double blur;
  final Color color;
  final double opacity;

  const GlassCheckbox({
    Key? key,
    required this.label,
    required this.value,
    this.onChanged,
    this.blur = 10.0,
    this.color = const Color(0xFFFFFFFF),
    this.opacity = 0.1,
  }) : super(key: key);

  @override
  State<GlassCheckbox> createState() => _GlassCheckboxState();
}

class _GlassCheckboxState extends State<GlassCheckbox> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(GlassCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(_value);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        borderRadius: 12,
        color: widget.color,
        opacity: widget.opacity,
        blur: widget.blur,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.white.withOpacity(0.6),
                  width: 1.5,
                ),
                color: _value ? Colors.white.withOpacity(0.2) : Colors.transparent,
              ),
              child: _value
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
            if (widget.label.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
