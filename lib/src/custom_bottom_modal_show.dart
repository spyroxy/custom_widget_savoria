import 'package:flutter/material.dart';
import 'custom_bottom_modal.dart';


  void showMyModal(
      BuildContext context,
      String title,
      String imgAssets,
      String buttonLabel,
      bool showButton,
      var onPressed
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) => WillPopScope(
          onWillPop: () => Future.value(false),
          child: CustomBottomModal(imgAssets: imgAssets,title: title, buttonLabel: buttonLabel, showButton: showButton,onPressed: onPressed,)), // Ini StatefulWidget
    );
  }


