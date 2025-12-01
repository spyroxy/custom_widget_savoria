
import 'package:custom_widget_savoria/src/custom_button_standard.dart';
import 'package:flutter/material.dart';

Future<void> CustomDialogStandard({
  required BuildContext context,
  required String title,
  required String content,
  String confirmText = "Close",
  String cancelText = "Cancel",
  VoidCallback? onConfirm,
  required Icon iconTitle,
  Icon iconConfirm = const Icon(Icons.close, color: Colors.white, size: 15,),
  Color colorConfirm = Colors.red,
  Color colorConfirmIcon = Colors.redAccent,
  Color colorCancel = Colors.red,
  TextStyle titleStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
  TextStyle contentStyle = const TextStyle(),
  bool showCancel = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false, // tidak bisa ditutup dengan tap luar
    builder: (_) {
      return WillPopScope(
        onWillPop: () async => false, // DISABLE BACK BUTTON
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iconTitle,
                const SizedBox(height: 10,),
                Text(
                  textAlign: TextAlign.center,
                  title,
                  style: titleStyle,
                ),
                const SizedBox(height: 16),
                Text(
                  textAlign: TextAlign.center,
                  content,
                  style: contentStyle,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showCancel)
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          cancelText,
                          style:  TextStyle(color: colorCancel, fontWeight: FontWeight.bold),
                        ),
                      ),
                    CustomButtonStandard(
                      onTap: () {
                        Navigator.pop(context);
                        if (onConfirm != null) onConfirm();
                      },
                      title: confirmText,
                      icon: iconConfirm,
                      colorButton: colorConfirm,
                      colorButtonIcon: colorConfirmIcon,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
