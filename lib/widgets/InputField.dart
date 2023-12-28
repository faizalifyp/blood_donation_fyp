import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';


class InputField extends StatelessWidget {
  final String hintText;
  final double width;
  final IconData icon;
  final Color color;
  final double height;
  final bool expands;
   int? maxLines;
    InputField({
     this.maxLines = null,
     this.expands = false,
    this.height = 50,
    required this.hintText,
     this.width = double.infinity,
    required this.icon,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration:const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 15,
            ),
          ]
      ),
      child: TextField(
        style: TextStyle(fontSize: 18.sp, color: knormalText),
        expands: true,
        maxLines: null,
        decoration: InputDecoration(

          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 18.sp, color: knormalText),
          prefixIcon: Icon(icon, color: color,),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
