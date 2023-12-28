import 'package:flutter/material.dart';
import '/constants/constant.dart';
import 'textwidget.dart';
class MainButton extends StatelessWidget {
  Color buttonTextColor;
  Color fillColor ;
  String buttonText;
  Function() onPressed;
  double width ;

   MainButton({
      this.width=double.infinity,
    required this.buttonText,
     this.fillColor = Colors.transparent,
    required this.buttonTextColor,
     required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 2,
          color: kmaincolor,
        ),
        color: fillColor,
      ),
      height: 50,
      padding:  const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextButton(
        child: TextWidget(text: buttonText, fontSize: 22, color: buttonTextColor,),
        onPressed: onPressed,
      ),
    );
  }
}
