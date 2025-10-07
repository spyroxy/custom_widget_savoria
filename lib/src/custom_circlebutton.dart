
import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
   CustomCircleButton(
      {Key? key,
        required this.icon,
        required this.text,
        required this.onPressed,
        required this.colorCircle,
        required this.colorIcon,
        required this.heightCircle,
        required this.widhtCircle,
        required this.sizeIcon,
         this.notif = false,
         this.colorText = Colors.black,

      })
      : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color colorCircle;
  final Color colorIcon;
   Color? colorText = Colors.black;
  final double heightCircle;
  final double widhtCircle;
  final double sizeIcon;
   bool notif = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [

          Column(
            children: [
              Container(
                width: widhtCircle,
                height: heightCircle,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorCircle, // Customize color as needed
                ),
                child: Icon(
                  icon,
                  color: colorIcon, // Customize icon color as needed
                  size: sizeIcon,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                text.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
         notif ? Positioned(
              top: 0,
              right: 0,
              child: Container(
                height:20,
                width: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red, // Customize color as needed
                ),
              )
          ) : const SizedBox(),
        ],
      )
    );
  }
}
