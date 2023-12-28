import 'package:blood_donation_fyp/screen/Introductory%20Pages/intropage2.dart';
import 'package:blood_donation_fyp/screen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/widgets/textwidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/constants/constant.dart';

class IntroPage1 extends StatefulWidget {



  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(
            //   height: 1.sh,
            //   child: PageView(
            //     controller: _controller,
            //     children:  [
            //       IntroPage1(),
            //       IntroPage2(),
            //     ],
            //   ),
            // ),
            // SmoothPageIndicator(
            //   controller: _controller,
            //   count: 2,
            //   effect: ExpandingDotsEffect(
            //     activeDotColor: kmaincolor,
            //     dotColor: knormalText,
            //     dotHeight: 10.h,
            //     dotWidth: 45.w,
            //     spacing: 16.w,
            //   ),
            // ),
            SizedBox(height: 0.1.sh,),
            SizedBox(
              height: 0.55.sh,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('images/blood_test.png'),
                  TextWidget(
                      text: 'Find Blood Donors',
                      fontSize: 24.sp,
                      color: kheading,
                      weight: FontWeight.w500),
                  Align(
                    alignment: Alignment.center,
                    child: TextWidget(
                      text: '',
                      fontSize: 20.sp,
                      color: knormalText,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 44.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));},
                    child: TextWidget(
                        text: 'Skip',
                        fontSize: 20,
                        color: kheading,
                      weight: FontWeight.w400,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
