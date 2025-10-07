import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.title = '',
      this.textAlign = TextAlign.center,
      this.onPressed,
      this.height = 50.0,
      this.elevation = 1.0,
      this.borderRadius = 24.0,
      this.color = Colors.black54,
      this.borderSide = const BorderSide(width: 0.0, style: BorderStyle.none),
      this.textStyle,
      this.icon,
        this.rightIcon = false,
      this.hasIcon = false,
      this.hasExpanded = false})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  final double height;
  final double elevation;
  final double borderRadius;
  final String title;
  final TextAlign textAlign;
  final Color color;
  final BorderSide borderSide;
  // ignore: prefer_typing_uninitialized_variables
  final textStyle;
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  final bool hasIcon;
  final bool hasExpanded;
  final bool rightIcon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: borderSide,
      ),
      height: height,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            rightIcon ?  const SizedBox() : hasIcon ? icon : const SizedBox(),
            rightIcon ? const SizedBox() : const SizedBox(width: 5,),
            // hasIcon
            //     ? const SizedBox(
            //         width: 8.0,
            //       )
            //     : Container(),
            title != ''
                ? hasExpanded
                    ? Expanded(
                        child: Text(
                          title.toUpperCase(),
                          style: textStyle,
                          textAlign: textAlign,
                        ),
                      )
                    : Text(
                        title.toUpperCase(),
                        style: textStyle,
              textAlign: textAlign,
                      )
                : Container(),

            !rightIcon ?  const SizedBox() : hasIcon ? icon : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
