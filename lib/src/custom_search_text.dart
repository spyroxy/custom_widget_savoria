import 'package:flutter/material.dart';

class CustomSearchText extends StatelessWidget {
  const CustomSearchText(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      required this.onPressed,})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  final TextEditingController textEditingController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: TextField(
        controller: textEditingController,
        cursorColor: Theme.of(context).primaryColor,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
        decoration: InputDecoration(
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          suffixIcon: SizedBox(
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(Colors.redAccent),),
              onPressed: onPressed,
              child:  const Icon(Icons.search, color: Colors.white,)
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
          labelStyle: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color ?? Theme.of(context).primaryColor),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Theme.of(context).textTheme.bodyLarge?.color ?? Theme.of(context).primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Theme.of(context).textTheme.bodyLarge?.color ?? Theme.of(context).splashColor),
          ),
          hintText: hintText,
          hintStyle:  Theme.of(context).textTheme.bodyLarge?.copyWith(),
          // hintStyle: TextStyle(color: Theme.of(context).splashColor.withOpacity(0.5)),
          filled: true,
        ),
      ),
    );
  }
}
