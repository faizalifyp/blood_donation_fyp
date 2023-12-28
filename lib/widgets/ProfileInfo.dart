import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';
import 'textwidget.dart';

class ProfileInfo extends StatelessWidget {
  final String bloodGroup;
  final String bloodGrouptext;
  const ProfileInfo({
    required this.bloodGroup,
    required this.bloodGrouptext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102.h,
      width: 102.w,
      decoration: const BoxDecoration(
        color: kwhite,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 5,
            color: Colors.white70,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextWidget(text: bloodGroup, fontSize: 30.sp, color: kheading),
          TextWidget(text: bloodGrouptext, fontSize: 14.sp, color: knormalText,),
        ],
      ),
    );
  }
}
