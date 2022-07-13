import 'package:flutter/material.dart';


Widget appBarMain(BuildContext context){
  return AppBar(
    title: Icon(Icons.message),
  );
}
InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
    hintText: hintText,
      hintStyle: TextStyle(
          color: Colors.white54
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      )
  );
}