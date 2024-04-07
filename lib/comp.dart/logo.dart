import 'package:flutter/material.dart';

class logo extends StatelessWidget {
  const logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Color(0xffF2F4FF), borderRadius: BorderRadius.circular(80)),
        height: 85,
        width: 85,
        child: Image.asset("assets/logo.png", width: 50, height: 50),
      ),
    );
  }
}
