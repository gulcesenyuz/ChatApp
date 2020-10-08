import 'package:flutter/material.dart';

import '../colors.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    backgroundColor: colorA,
    title:Image.asset("assets/images/newrolename.png",
      height: 40,) ,

  );
}

InputDecoration textFieldInputDecoration(String hintText){
  return  InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
        color: Colors.white54
    ),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white)
    ),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white54)
    ),
  );
}
TextStyle simpleTextFieldStyle(){
  return TextStyle(
    // yazarkenki renk
    color: Colors.white70,
  );
}
