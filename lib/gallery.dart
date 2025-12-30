import 'dart:convert';

import 'package:custom_widget_savoria/custom_widget.dart';
import 'package:custom_widget_savoria/src/custom_button_standard.dart';
import 'package:custom_widget_savoria/src/custom_dialog_standard.dart';
import 'package:custom_widget_savoria/src/custom_textfield_standard.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _loginpageState();
}

class _loginpageState extends State<GalleryPage> {


  TextEditingController txtSample = TextEditingController();

  int devCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: SizedBox(),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              CustomButtonStandard(
                onTap: (){
                  CustomDialogStandard(context: context, title: 'title', content: 'contentcontentcontentcontentcontentcontentcontentcontentcontent', iconTitle: Icon(Icons.add_alert, size: 30,), confirmText: 'Hapus Data', showCancel: true);
                },
                title: 'Tambah',
                icon: Icon(Icons.add, color: Colors.white,),
              ),
              const CustomTextFieldStandard(
                hint: "you@savoria.co.id",
                label: "Username",
                icon: Icons.email,
              ),

              SizedBox(
                width: 550,
                child: const CustomTextFieldStandard(
                  hint: "you@savoria.co.id",
                  label: "Password",
                  icon: Icons.lock,
                  colorObscure: Colors.purple,
                  obscure: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
