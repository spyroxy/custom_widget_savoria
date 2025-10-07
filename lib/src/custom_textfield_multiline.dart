import 'package:flutter/material.dart';

class CustomTextFieldMultiLine extends StatelessWidget {
  const CustomTextFieldMultiLine(
      {Key? key,
      required this.labelText,
      required this.textEditingController,
        required this.maxLine,
        required this.minLine,
      this.onChange})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final String labelText;
  final TextEditingController textEditingController;
  final int maxLine;
  final int minLine;
  final onChange;

  @override
  Widget build(BuildContext context) {
    return   Container(
        width: MediaQuery.of(context).size.width/1.5,
        padding: const EdgeInsets.only(right: 20,left: 20),
        child: TextField(
          cursorColor: Theme.of(context).textTheme.bodyLarge?.color,
          controller: textEditingController,
          keyboardType: TextInputType.text,
          style:  TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyLarge?.color),
          maxLines: maxLine,
          minLines: minLine,
          onChanged: onChange,
          decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black)
              ),
          ),
        )
    );
  }
}
