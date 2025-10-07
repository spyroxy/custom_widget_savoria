import 'package:flutter/material.dart';

class CustomButtonFilter extends StatelessWidget {
  const CustomButtonFilter(
      {Key? key,
      this.title = '',
      this.onPressed,
      this.height = 50.0,
      this.elevation = 1.0,
      this.borderRadius = 24.0,
      this.color = Colors.black45,
      this.borderSide = const BorderSide(width: 0.0, style: BorderStyle.none),
      this.textStyle,
      this.icon,
        this.rightIcon = false,
      this.hasIcon = false,
      this.isCircle = false,
      this.hasExpanded = false})
      : super(key: key);


  // static const BorderSide defaultPrimaryBorder = BorderSide(width: 0.0, style: BorderStyle.none);
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  final double height;
  final double elevation;
  final double borderRadius;
  final String title;
  final Color color;
  final BorderSide borderSide;
  // ignore: prefer_typing_uninitialized_variables
  final textStyle;
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  final bool hasIcon;
  final bool hasExpanded;
  final bool rightIcon;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.5),
      child: MaterialButton(
        onPressed: onPressed,
        elevation: 0,
        shape: isCircle ?  const CircleBorder() : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: borderSide,
        ),
        color: Colors.grey.withOpacity(0.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            rightIcon ?  const SizedBox() : hasIcon ? icon : const SizedBox(),
            title != ''
                ? hasExpanded
                    ? Expanded(
                        child: Text(
                          title.toUpperCase(),
                          style: textStyle,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Text(
                        title.toUpperCase(),
                        style: textStyle,
              textAlign: TextAlign.center,
                      )
                : Container(),

          ],
        ),
      ),
    );
  }
}
