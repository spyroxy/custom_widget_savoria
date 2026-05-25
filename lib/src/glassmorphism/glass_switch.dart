import 'package:flutter/material.dart';

import 'glass_container.dart';

class GlassSwitch extends StatefulWidget {
  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final double blur;
  final Color color;
  final double opacity;

  const GlassSwitch({
    Key? key,
    required this.label,
    required this.value,
    this.onChanged,
    this.blur = 10.0,
    this.color = const Color(0xFFFFFFFF),
    this.opacity = 0.1,
  }) : super(key: key);

  @override
  State<GlassSwitch> createState() => _GlassSwitchState();
}

class _GlassSwitchState extends State<GlassSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(GlassSwitch oldWidget) {
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
            // Custom Glass Switch Toggle
            Container(
              width: 44,
              height: 24,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 1.5,
                ),
                color: _value ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.05),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: _value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (widget.label.isNotEmpty) ...[
              const SizedBox(width: 10),
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
