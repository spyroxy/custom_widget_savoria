import 'package:flutter/material.dart';

import 'custom_button.dart';


class DscaDialog {
  static void dialogDsca(BuildContext context, String title, String content, bool twoButton, String buttonOk, var okPressed, Color colorButtonOk)
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomButton(
                      title: 'TUTUP',
                      color: Theme.of(context).primaryColor,
                      borderRadius: 10.0,
                      textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: ()  {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 10,),
                    twoButton ? CustomButton(
                        title: buttonOk,
                        color: colorButtonOk,
                        borderRadius: 10.0,
                        textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: okPressed
                    ) : const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }


  static void dialogDscaTwoButton(BuildContext context, String title, String content,
      String buttonOne, var okPressedOne, Color colorButtonOne,
      String buttonTwo, var okPressedTwo, Color colorButtonTwo,

      )
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomButton(
                        title: buttonOne,
                        color: colorButtonOne,
                        borderRadius: 10.0,
                        textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: okPressedOne
                    ),
                    const SizedBox(width: 10,),
                    CustomButton(
                        title: buttonTwo,
                        color: colorButtonTwo,
                        borderRadius: 10.0,
                        textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: okPressedTwo
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }


  static void dialogWarning(BuildContext context, String title, String content, String textButton, var onPressed)
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: CustomButton(
                        title: textButton,
                        color: Colors.red,
                        borderRadius: 10.0,
                        textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: onPressed
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}