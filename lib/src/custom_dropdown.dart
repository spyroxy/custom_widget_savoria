import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {Key? key,
        required this.onTap,
      required this.labelText,
      required this.textEditingController,
      required this.hintText,})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final String labelText;
  final TextEditingController textEditingController;
  final String hintText;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return   TextFormField(
          controller: textEditingController,
          readOnly: true,
          decoration: InputDecoration(
            focusColor: Colors.black,
            fillColor: Colors.white,
            suffixIcon: const Icon(Icons.arrow_drop_down, size: 25),
            labelText: labelText,
            hintText: hintText,
            hoverColor: Colors.redAccent,
            filled: true,
            border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:  const BorderSide(color: Colors.redAccent)
            ),
          ),
          onTap: onTap

    );
  }
}
