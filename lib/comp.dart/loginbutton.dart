import 'package:flutter/material.dart';

class custombutton extends StatelessWidget {
  final void Function()? onpressed;
  final String buttonName;
  const custombutton({super.key, this.onpressed, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpressed,
      height: 45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: const Color.fromARGB(255, 255, 186, 81),
      child: Text(
        buttonName,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
