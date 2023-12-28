import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';
import 'textwidget.dart';

class BloodTestReport extends StatelessWidget {
  final double percentage;
  final String Name;

  const BloodTestReport({
    required this.percentage,
    required this.Name,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 87.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow:const [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 15,
              color: Colors.black12,
            ),
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextWidget(text: '$percentage mmol/L', fontSize: 14, color: kheading),
          TextWidget(text: '$Name', fontSize: 16, color: knormalText),
        ],
      ),
    );
  }
}
