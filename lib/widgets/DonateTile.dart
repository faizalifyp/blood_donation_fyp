import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Models/DonationRequestList.dart';
import '../constants/constant.dart';
import 'textwidget.dart';

class BloodRequestTile extends StatelessWidget {
  final String hospitalName;
  final String city;
  final String bloodGroup;
  final String status;

  const BloodRequestTile({
    required this.hospitalName,
    required this.city,
    required this.status,
    required this.bloodGroup,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374.w,
      height: 146.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                    text: 'Hospital Name',
                    fontSize: 14,
                    color: knormalText),
                TextWidget(
                    text: hospitalName,
                    fontSize: 14,
                    color: kheading),
                TextWidget(
                    text: 'City',
                    fontSize: 14,
                    color: knormalText),
                TextWidget(
                    text: city,
                    fontSize: 14,
                    color: kheading),
                TextWidget(
                    text: 'Status',
                    fontSize: 14,
                    color: knormalText),
                TextWidget(
                    text: status.toUpperCase(),
                    fontSize: 14,
                    color: kheading),

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 40.w,
                  height: 55.h,
                  decoration:const BoxDecoration(
                    image: DecorationImage(image: AssetImage('images/blood_group.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: TextWidget(
                      text: bloodGroup,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextWidget(
                  text: 'Donate',
                  fontSize: 18,
                  color: kmaincolor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

