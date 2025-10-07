import 'package:flutter/material.dart';

class CustomExpand extends StatefulWidget {
  /// A parameter that is used to show the content of the widget.
  final Widget content;

  /// A parameter that is used to show the title of the widget.
  final Widget title;
  final Widget subTitle;

  /// A parameter that is used to show the trailing widget.
  final Widget? trailing;
  final Widget? leading;

  /// A parameter that is used to set the color of the widget.
  final Color? color;

  /// Used to set the color of the shadow.
  final List<BoxShadow>? boxShadow;

  /// Used to make the widget scrollable.
  final bool? scrollable;

  /// Used to set the height of the widget when it is closed.
  final double? closedHeight;

  /// Used to set the height of the widget when it is opened.
  final double? openedHeight;

  /// Used to set the duration of the animation.
  final Duration? duration;

  /// Used to set the padding of the widget when it is closed.
  final double? onTapPadding;

  /// Used to set the border radius of the widget.
  final double? borderRadius;

  /// Used to set the physics of the scrollable widget.
  final ScrollPhysics? scrollPhysics;

  /// A constructor.
  const CustomExpand({
    Key? key,
    required this.content,
    required this.title,
    required this.subTitle,
    this.color,
    this.scrollable,
    this.closedHeight,
    this.openedHeight,
    this.boxShadow,
    this.duration,
    this.onTapPadding,
    this.borderRadius,
    this.scrollPhysics,
    this.trailing,
    this.leading,
  }) : super(key: key);
  @override
  _TapToExpandState createState() => _TapToExpandState();
}

class _TapToExpandState extends State<CustomExpand> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    bool scrollable = widget.scrollable ?? false;

    /// Used to make the widget clickable.
    return AnimatedContainer(
      // margin: EdgeInsets.symmetric(
      //   /// Used to set the padding of the widget when it is closed.
      //   horizontal: isExpanded ? 25 : widget.onTapPadding ?? 10,
      //   vertical: 0,
      // ),
      // height:
      //
      // /// Used to set the height of the widget when it is closed and opened depends on the isExpanded parameter.
      // isExpanded ? widget.closedHeight ?? 80 : widget.openedHeight ?? 440,
      curve: Curves.fastLinearToSlowEaseIn,
      duration: widget.duration ?? const Duration(milliseconds: 1200),
      child: scrollable
          ? ListView(
        physics: widget.scrollPhysics,
        children: [
          ListTile(
            onTap: (){
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            title: widget.title,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.subTitle,
                const Divider()
              ],
            ),
            leading: widget.leading,
            trailing: widget.trailing ??
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                ),
          ),

          /// Used to add some space between the title and the content.
          isExpanded ? const SizedBox() : const SizedBox(height: 20),

          /// Used to show the content of the widget.
          AnimatedCrossFade(
            firstChild: const Text(
              '',
              style: TextStyle(
                fontSize: 0,
              ),
            ),

            /// Showing the content of the widget.
            secondChild: widget.content,
            crossFadeState: isExpanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration:
            widget.duration ?? const Duration(milliseconds: 1200),
            reverseDuration: Duration.zero,
            sizeCurve: Curves.fastLinearToSlowEaseIn,
          ),
        ],
      )
          : Column(
        children: [

          ListTile(
            onTap: (){
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            title: widget.title,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.subTitle,
                const Divider()
              ],
            ),
            leading: widget.leading,
            trailing: widget.trailing ??
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  size: 40,
                  color: isExpanded
                      ? Theme.of(context).primaryColor
                      : Colors.redAccent,
                ),
          ),

          /// Used to add some space between the title and the content.
          isExpanded ? const SizedBox() : const SizedBox(height: 20),

          /// Used to show the content of the widget.
          AnimatedCrossFade(
            firstChild: const Text(
              '',
              style: TextStyle(
                fontSize: 0,
              ),
            ),
            secondChild: widget.content,
            crossFadeState: isExpanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,

            /// Used to set the duration of the animation.
            duration:
            widget.duration ?? const Duration(milliseconds: 1200),
            reverseDuration: Duration.zero,

            /// Used to set the curve of the animation.
            sizeCurve: Curves.fastLinearToSlowEaseIn,
          ),
        ],
      ),
    );
  }
}
