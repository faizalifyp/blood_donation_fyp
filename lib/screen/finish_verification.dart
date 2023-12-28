import 'package:blood_donation_fyp/constants/constant.dart';
import 'package:blood_donation_fyp/screen/loginscreen.dart';
import 'package:blood_donation_fyp/widgets/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinishVerification extends StatefulWidget {
  const FinishVerification({Key? key}) : super(key: key);

  @override
  State<FinishVerification> createState() => _FinishVerificationState();
}

class _FinishVerificationState extends State<FinishVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/success.png'),
            SizedBox(height: 100.h),
            MainButton(
                buttonText: 'Finish',
                buttonTextColor: kwhite,
                fillColor: kmaincolor,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen(),),);
                },
            ),
            SizedBox(height: 250.h),
          ],
        ),
      ),
    );
  }
}
