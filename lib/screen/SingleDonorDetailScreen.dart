import 'package:blood_donation_fyp/constants/constant.dart';
import 'package:blood_donation_fyp/widgets/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import '../Models/DonarsDetails.dart';
import '../widgets/ProfileButton.dart';

class SingleDonorDetailScreen extends StatefulWidget {
  final int index;
  const SingleDonorDetailScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<SingleDonorDetailScreen> createState() =>
      _SingleDonorDetailScreenState();
}

class _SingleDonorDetailScreenState extends State<SingleDonorDetailScreen> {
  // print("details are $details");
  @override
  Widget build(BuildContext context) {
    // Container hw
    // Stack
    // Position top -10 left:0  child Row Center Image

    return Container(
      width: 1.sw,
      height: .79.sh,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          topLeft: Radius.circular(50),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 15,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              SizedBox(
                height: 78.h,
              ),
              TextWidget(
                // text: widget.details,
                text: usersDonorsList[widget.index].name,
                fontSize: 22,
                color: kheading,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: kmaincolor,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  TextWidget(
                      text: usersDonorsList[widget.index].location,
                      fontSize: 14,
                      color: knormalText),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 28.w),
                    child: Container(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.clean_hands_outlined,
                            color: kmaincolor,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            children: [
                              TextWidget(
                                text: '${DonorsList[widget.index].TimeDonated}',
                                fontSize: 16,
                                color: kmaincolor,
                              ),
                              TextWidget(
                                text: ' Times Donated',
                                fontSize: 16,
                                color: knormalText,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 28.w),
                    child: Container(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.bloodtype_outlined,
                            color: kmaincolor,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Blood Type ',
                                fontSize: 16,
                                color: knormalText,
                              ),
                              TextWidget(
                                text: '${usersDonorsList[widget.index].bloodGroup}',
                                fontSize: 16,
                                color: kmaincolor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 35.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [
                  ProfileButton(
                      text: 'Call Now',
                      icon: Icons.call,
                      color: kcallbuttoncolor,
                    phoneNumber: usersDonorsList[widget.index].phone, // Replace with the desired phone number
                  ),
                  ProfileButton(
                    text: 'Request',
                    icon: Icons.arrow_back,
                    color: kmaincolor,
                    phoneNumber: '', // Replace with the desired phone number

                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    // SizedBox(height: 50.h),
                    Container(
                      width: 1.sw,
                      height: 277.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),

                        image: const DecorationImage(
                            image: AssetImage('images/Map/map.png'),
                            fit: BoxFit.cover),
                      ),
                      // child: Image.asset('images/Map/map.png', fit: BoxFit.cover,),
                    ),
                    Positioned(
                      bottom: 45.h,
                      child: Container(
                        width: 141.w,
                        height: 141.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          image: const DecorationImage(
                              image: AssetImage('images/Map/roundArea.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50.h,
                      child: Container(
                        width: 141.w,
                        height: 141.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: kmaincolor,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20.w,
                      bottom: 20.h,
                      child: Container(
                        width: 49.w,
                        height: 49.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: kmaincolor,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Transform.rotate(
                              angle: 45 * math.pi / 180,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 36.69.w,
                                  height: 36.69.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    border:
                                        Border.all(width: 1.sp, color: kwhite),
                                  ),
                                  child: Transform.rotate(
                                      angle: -45 * math.pi / 180,
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        color: kwhite,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            // bottom: 460.h,
            top: -80.h,
            left: 0,
            child: SizedBox(
              width: 1.sw,
              child: Center(
                child: Container(
                  width: 130.w,
                  height: 130.h,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.w, color: Colors.white),
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage(DonorsList[widget.index].image),
                        fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // child: Image.asset(DonorsList[widget.index].image),
    );
  }
}
