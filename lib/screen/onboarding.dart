import '/screen/loginscreen.dart';
import '/screen/signup.dart';
import 'package:flutter/material.dart';
import '../widgets/mainbutton.dart';
import '/widgets/textwidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/constants/constant.dart';


class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 140.h,
            ),
            Stack(
              children: [
                Image.asset('images/vector_red.png'),
                Positioned(
                  top: 65,
                  bottom: 70,
                  right: 49.08,
                  left: 46.88,
                  child:
                Container(
                  width: 13.75.w,
                  height: 20.56.h,
                  child: Image.asset('images/vector_red.png'),
                ),
                ),
                Positioned(
                  top: 100,
                  bottom: 40,
                  right: 20,
                  left: 70,
                  child: Container(
                    width: 13.75.w,
                    height: 20.56.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/vector_red.png'),
                      ),
                    ),
                  ),
                ),
                Positioned(

                  top: 125,
                  bottom: 15,
                  right: 55,
                  left: 40,
                  child: Container(
                    width: 20.75.w,
                    height: 25.56.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/vector_red.png'),
                      ),
                    ),
                  ),
                ),  //
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 3,),
                TextWidget(text: 'Dare', fontSize: 30, color: kmaincolor),
                Spacer(),
                TextWidget(text: 'To', fontSize: 30, color: kheading),
                Spacer(),
                TextWidget(text: 'Donate', fontSize: 30, color: kmaincolor),
                Spacer(flex: 3,),
              ],
            ),
            Spacer(),
            TextWidget(
                text: 'You can donate for ones in need and request blood if you need.',
                fontSize: 20,
                color: knormalText,
              weight: FontWeight.w200,
            ),
            Spacer(flex: 3,),
            MainButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder:
                    (constex)=>const LoginScreen(),
                ),
                );
              },
              buttonText: 'LOG IN',
              buttonTextColor: kmaincolor,
            ),
            Spacer(),
            MainButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder:
                    (constex)=>const
                      SignUp(),
                ),
                );
              },
              buttonText: 'REGISTER',
              buttonTextColor: kwhite,
              fillColor: kmaincolor,
            ),
            Spacer(flex: 5,),
          ],
        ),
      ),
    );
  }
}

