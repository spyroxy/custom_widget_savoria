import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
        this.enabled = true,
      required this.labelText,
      required this.textEditingController,
      required this.hintText,
        this.readOnly = false,
        this.textInBox = true,
        this.prefix = false,
        this.isPassword = false,
        this.iconPrefix = const Icon(Icons.add),
        this.onTap,
        this.colorCursor = Colors.black,
        this.colorFill = Colors.white,
        this.colorLabel = Colors.black,
        this.colorBorder = Colors.white,
        this.onPressedPassword,
        this.obscureText = false,
      required this.keyboardNumber})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final String labelText;
  final TextEditingController textEditingController;
  final String hintText;
  final bool keyboardNumber;
  final bool readOnly;
  final bool textInBox;
  final bool prefix;
  final bool isPassword;
  final Widget iconPrefix;
  final void Function()? onTap;
  final void Function()? onPressedPassword;
  final bool enabled;
  final Color colorCursor;
  final Color colorFill;
  final Color colorLabel;
  final Color colorBorder;

  final bool obscureText ;

  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textInBox ? const SizedBox() : Text(labelText),
        TextField(
          cursorColor: colorCursor,
          controller: textEditingController,
          enabled: enabled,
          keyboardType: keyboardNumber ? TextInputType.number : TextInputType.text,
          style:  TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyLarge?.color),
          inputFormatters: <TextInputFormatter>[
            keyboardNumber ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter, // Hanya menerima input angka
          ],
          maxLines: 1,
          obscureText: obscureText,
          decoration: InputDecoration(
              labelText: textInBox ? labelText : null,
              filled: true,
              fillColor: colorFill,
              prefixIcon: prefix ? iconPrefix : null,
              suffixIcon: isPassword ? IconButton(
                  onPressed: onPressedPassword, icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
              )) : null,

              labelStyle: TextStyle(color: colorLabel),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: colorBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: colorBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: colorBorder),
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.black38)
          ),
          readOnly: readOnly,
          onTap: onTap,
        ),
      ],
    );
  }
}
