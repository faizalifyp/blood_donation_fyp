import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';
import 'textwidget.dart';

class HomePageButtons extends StatelessWidget {
  final String imageAddress;
  final String Text;

  const HomePageButtons({
    required this.imageAddress,
    required this.Text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 111.h,
      width: 111.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 15,
            ),
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(imageAddress),
          TextWidget(
            text: Text,
            fontSize: 14,
            color: knormalText,
          ),
        ],
      ),
    );
  }
}
