import 'package:flutter/material.dart';
import 'custom_button.dart';




class CustomBottomModal extends StatelessWidget {


   CustomBottomModal(
      {Key? key,
        this.title = '',
        this.imgAssets = '',
        this.buttonLabel = '',
        this.onPressed,
        this.colorFill = Colors.blue,
        this.showButton = true})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final String title;
  final String imgAssets;
  final String buttonLabel;
  final bool showButton;
  final Color colorFill;
  var onPressed;



  @override
  Widget build(BuildContext context) {


    return Container(
      height: MediaQuery.of(context).size.height/2.3,
      width: MediaQuery.of(context).size.width,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40,),
          Text(title, textAlign: TextAlign.center,),
          const SizedBox(height: 40,),
          Image.asset(imgAssets, width: 100,height: 100,),
          const SizedBox(height: 40,),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: CustomButton(
              color: colorFill,
              textStyle: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              title: buttonLabel,
              onPressed: onPressed
            ),
          )
        ],
      ),
    );
  }
}
