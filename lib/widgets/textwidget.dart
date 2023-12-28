import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
   TextWidget({
     required this.text,
     required this.fontSize,
     required this.color,
     this.weight= FontWeight.normal,
    super.key,
  });
String text;
double fontSize;
Color color;
FontWeight weight;
  @override
  Widget build(BuildContext context) {
    return  Text(text,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          fontFamily: 'PoppinsRegular',
          color: color,

      ),
    );
  }
}
