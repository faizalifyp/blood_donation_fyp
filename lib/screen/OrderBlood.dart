import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';
import '../widgets/textwidget.dart';

class OrderBlood extends StatefulWidget {
  const OrderBlood({Key? key}) : super(key: key);

  @override
  State<OrderBlood> createState() => _OrderBloodState();
}

class _OrderBloodState extends State<OrderBlood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 38.h),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 50.w),
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
                        text: 'Search',
                        fontSize: 22,
                        color: kheading,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50.h,
                    width: 300.w,
                    decoration:const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 15,
                        ),
                      ]
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 18.sp, color: knormalText),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(fontSize: 18.sp, color: knormalText),
                        prefixIcon: Icon(Icons.search_outlined, color: knormalText,),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Image.asset('images/filtericon1.png', width: 48.w,height: 48.h,),
                      Positioned(
                        top: 8.h,
                          left: 12.w,
                          child: Image.asset('images/filtericon2.png', width: 22.w, height: 32.h,)),
                    ],
                  ),

                ],

              ),
              SizedBox(height: 29.h,),
              Container(
                height: .60.sh,
                width: 1.sw,

                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      spreadRadius: 1
                    )
                  ],
                    color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: TextWidget(
                          text: 'Filters',
                          fontSize: 18,
                          color: kheading,
                        weight: FontWeight.w500,
                      ),
                    ),
                    Divider(thickness: 3.sp,),
                    SizedBox(height: 5.h,),
                    Divider(thickness: 3.sp,),
                    Row(
                      children: [
                        TextWidget(
                            text: 'Blood Type',
                            fontSize: 16,
                            color: kheading,
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
