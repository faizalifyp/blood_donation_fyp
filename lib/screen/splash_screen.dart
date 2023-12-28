import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Introductory Pages/intropage.dart';
import 'Introductory Pages/intropage1.dart';
import '../widgets/textwidget.dart';
import '/constants/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void splash(){
    Future.delayed(
      const Duration(seconds: 05),
          ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder:
              (context)=> IntroPage(),
          ),
          ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w,
      height: 1.h,
      color: kmaincolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 0.15.sh,
          ),
          Stack(
            children: [
              Container(
                width: 114.w,
                height: 171.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/vector.png'),
                  ),
                ),
              ),
              Positioned(
                top: 80,
                bottom: 60,
                right: 49.08,
                left: 46.88,
                child: Container(
                width: 16.75.w,
                height: 25.56.h,
              //  color: Colors.green,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/vector.png'),
                  ),
                ),
              ),
              ),
              Positioned(
                top: 100,
                bottom: 40,
                right: 25,
                left: 60,
                child: Container(
                  width: 20.75.w,
                  height: 25.56.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/vector.png'),
                    ),
                  ),
                ),
              ),
              Positioned(

                top: 120,
                bottom: 20,
                right: 49,
                left: 46,
                child: Container(
                  width: 20.75.w,
                  height: 25.56.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/vector.png'),
                    ),
                  ),
                ),
              ),  //
            ],
          ),
          const Spacer(),
          TextWidget(
            text: 'Dare To Donate',
            fontSize: 33,
            color: kwhite,
            weight: FontWeight.w600,
          ),
          const Spacer(flex: 5,),
          SizedBox(
            width: 1.sw,
            height: 0.35.sh,
            child: const Image(
              fit: BoxFit.cover,
              image: AssetImage('images/splashbottomimage.png'),
            ),
          ),
        ],
      ),
    );
  }
}

