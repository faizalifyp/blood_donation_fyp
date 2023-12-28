import 'package:blood_donation_fyp/widgets/BloodTestReport.dart';
import 'package:blood_donation_fyp/widgets/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';
import '../widgets/textwidget.dart';

class Report extends StatelessWidget {
  const Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 38.h),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 70.w),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: knormalText,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,color: kheading,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 29.w),
                    child: TextWidget(
                      text: 'Report',
                      fontSize: 22,
                      color: kheading,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 38.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/location_icon.png'),
                TextWidget(text: '  Reseach Center', fontSize: 14, color: knormalText),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(text: 'Dhaka Medical College, Dhaka.', fontSize: 14, color: knormalText),
              ],
            ),
            SizedBox(height: 25.h,),
            Image.asset('images/report_img.png'),
            SizedBox(height: 30.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                BloodTestReport(percentage: 6, Name: 'Glucose'),
                BloodTestReport(percentage: 6.2, Name: 'Cholesterol'),
                BloodTestReport(percentage: 12, Name: 'Bilirubin'),
              ],
            ),
            SizedBox(height: 15.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:const [
                BloodTestReport(percentage: 3.6, Name: 'RBC'),
                BloodTestReport(percentage: 102, Name: 'MCV'),
                BloodTestReport(percentage: 276, Name: 'Platelets'),
              ],
            ),
            SizedBox(height: 50.h,),
            MainButton(
              width: 190.w,
                buttonText: 'My Report',
                buttonTextColor: kwhite,
                fillColor: kmaincolor,
                onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}

