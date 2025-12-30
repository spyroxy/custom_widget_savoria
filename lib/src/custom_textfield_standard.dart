import 'package:flutter/material.dart';

class CustomTextFieldStandard extends StatefulWidget {
  final String hint;
  final String label;
  final IconData icon;
  final Color colorObscure;
  final Color colorIcon;

  final bool obscure;
  final TextEditingController? controller;

  const CustomTextFieldStandard({
    super.key,
    required this.hint,
    required this.label,
    required this.icon,
    this.obscure = false,
    this.colorObscure = Colors.grey,
    this.colorIcon = Colors.grey,
    this.controller,
  });

  @override
  State<CustomTextFieldStandard> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomTextFieldStandard> {
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    isObscure = widget.obscure;
  }


  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: Text(widget.label)),
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12),

          ),
          child: Row(
            children: [
              /// LEFT ICON BOX
              Container(
                width: 50,
                height: 55,
                decoration:  BoxDecoration(
                  color: widget.colorIcon,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Icon(widget.icon, color: Colors.white),
              ),

              /// DIVIDER
              Container(
                width: 1,
                height: 40,
                color: Colors.black12,
              ),

              /// TEXT FIELD
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: widget.controller,
                    obscureText: widget.obscure ? isObscure : false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hint,
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      suffixIcon: widget.obscure
                          ? IconButton(
                        icon: Icon(
                          isObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: widget.colorObscure,
                        ),
                        onPressed: () {
                          setState(() => isObscure = !isObscure);
                        },
                      )
                          : null,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
