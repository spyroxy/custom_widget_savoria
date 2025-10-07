import 'package:flutter/material.dart';

import 'custom_button.dart';



class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {Key? key,
        this.titleOk = '',
        this.titleCancel = '',
        this.transparent = 1,
        this.onBack = true,
        required this.body,
      this.onPressedOk,
        this.onPressedCancel,
        required this.hasButtonOk,
      this.height = 100})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final onPressedOk;
  final onPressedCancel;
  final titleOk;
  final titleCancel;
  final bool hasButtonOk;
  final Widget body;
  final double height;
  final bool onBack;
  final double transparent;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Future.value(onBack);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(transparent),
        body: Stack(
          children: [
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: height),
                child: body),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 150,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 80,right: 80),
                        child: CustomButton(
                            title: titleOk,
                            color: Colors.blueAccent,
                            borderRadius: 10.0,
                            textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            onPressed: onPressedOk
                        ),

                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 80,right: 80, top: 10, bottom: 10),
                        child: CustomButton(
                            title: titleCancel,
                            color: Theme.of(context).primaryColor,
                            borderRadius: 10.0,
                            textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            onPressed: onPressedCancel
                        ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );




  }
}
