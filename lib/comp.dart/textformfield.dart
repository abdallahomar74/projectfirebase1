import 'package:flutter/material.dart';

class customtextformfield extends StatelessWidget {
  final TextEditingController mycontroller;
  final bool ocurrency;
  final String hinttext;
  final String? Function(String?)? validator;
  const customtextformfield(
      {super.key,
      required this.mycontroller,
      required this.ocurrency,
      required this.hinttext,required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator ,
      controller: mycontroller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
          hintText: hinttext,
          hintStyle: TextStyle(
              color: Color.fromARGB(255, 125, 125, 125), fontSize: 16),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffe6e6e8), width: 2),
              borderRadius: BorderRadius.circular(50)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffeef0f2), width: 2),
              borderRadius: BorderRadius.circular(50)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffeef0f2), width: 2),
              borderRadius: BorderRadius.circular(50)),
          fillColor: Color(0xffeef0f2),
          filled: true),
      obscureText: ocurrency,
    );
  }
}
