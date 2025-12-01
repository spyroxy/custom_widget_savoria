import 'package:flutter/material.dart';


class CustomButtonStandard extends StatelessWidget {
  const CustomButtonStandard(
      {Key? key,
        this.onTap,
        this.borderRadius = 5.0,
        this.colorButton = Colors.purpleAccent,
        this.colorButtonIcon = Colors.purple,
        this.titleStyle = const TextStyle(color: Colors.white),
      this.title = '',
      this.icon,
        this.mainAxisSize = MainAxisSize.min
      })
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final onTap;
  final double borderRadius;
  final String title;
  final Color colorButton;
  final Color colorButtonIcon;
  final titleStyle;
  final icon;
  final MainAxisSize mainAxisSize;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorButton,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        child: Row(
          mainAxisSize: mainAxisSize,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colorButtonIcon,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRadius), bottomLeft: Radius.circular(borderRadius)),
              ),
              child: icon,
            ),
            const SizedBox(width: 10),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text(
                title,
                style: titleStyle,
              ),
            ),
           const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
