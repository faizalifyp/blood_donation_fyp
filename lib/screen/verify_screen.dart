import 'dart:async';

import 'finish_verification.dart';
import 'reset_password.dart';
import 'package:blood_donation_fyp/screen/signup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/textformfield.dart';
import '/constants/constant.dart';
import '/widgets/textwidget.dart';
import '/widgets/mainbutton.dart';


import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {

  TextEditingController _firstDigitController = TextEditingController();
  TextEditingController _secondDigitController = TextEditingController();
  TextEditingController _thirdDigitController = TextEditingController();
  TextEditingController _forthDigitController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }

  int _remainingSeconds = 60;
  late Timer _timer;

  void timer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          timer.cancel();
          _showSnackBar();
          Timer.periodic(Duration(seconds: 3), (timer) {
            Navigator.pop(context);
          });
        }
      });
    });
  }



  void _showSnackBar(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:
      Text('Time Up'),
      ),
    );
  }







  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 30.w),
                  Expanded(
                    child: Textformfield(
                      controller: _firstDigitController,
                      hintText: '',
                      obsecureText: false,
                      keybordtype: TextInputType.number,
                      icon: Icons.numbers,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a Number';
                        }
                        return '';
                      },
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Textformfield(
                      controller: _secondDigitController,
                      hintText: '',
                      obsecureText: false,
                      keybordtype: TextInputType.number,
                      icon: Icons.numbers,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a Number';
                        }
                        return '';
                      },
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Textformfield(
                      controller: _thirdDigitController,
                      hintText: '',
                      obsecureText: false,
                      keybordtype: TextInputType.number,
                      icon: Icons.numbers,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a Number';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Textformfield(
                      controller: _forthDigitController,
                      hintText: '',
                      obsecureText: false,
                      keybordtype: TextInputType.number,
                      icon: Icons.numbers,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a Number';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 30.w),
                ],
              ),
            ),
            SizedBox(height: 40.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextWidget(
                  text: 'Resend Code $_remainingSeconds Sec',
                  fontSize: 16,
                  color: kmaincolor,
                ),
              ],
            ),
            SizedBox(height: 15.h),
            MainButton(
              buttonText: 'Verify',
              buttonTextColor: kwhite,
              fillColor: kmaincolor,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if(_remainingSeconds == 0){
                    Navigator.pop(context);
                  }else{
                    Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) => const FinishVerification(),
                      ),
                    );
                  }
                }

              },
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _firstDigitController.dispose();
    _secondDigitController.dispose();
    _thirdDigitController.dispose();
    _forthDigitController.dispose();
    super.dispose();
  }

}

