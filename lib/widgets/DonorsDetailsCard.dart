import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';
import 'textwidget.dart';

class DonorDetailsCard extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final String bloodgroup;
  const DonorDetailsCard({
    required this.name,
    required this.location,
    required this.image,
    required this.bloodgroup,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25.h),
      child: Container(
        width: 1.sw,
        height: 111.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            SizedBox(height: 10.h,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 14.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: image == null || image == ''
                    ?
                     CircleAvatar(
                  radius: 28.0, // Adjust the radius as needed
                  backgroundColor: Colors.white, // Set a desired color for the empty circle
                ) : Image.network(
                  image ?? '', // Use '??' to handle null values
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      // Display a circular placeholder while the image is loading
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: name,
                        fontSize: 16,
                        color: kheading,
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: kmaincolor,),
                          TextWidget(
                            text: location,
                            fontSize: 12,
                            color: knormalText,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Container(
                      width: 35.w,
                      height: 50.h,
                      decoration:const BoxDecoration(
                        image: DecorationImage(image: AssetImage('images/blood_group.png',),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Center(
                        child: TextWidget(
                          text: bloodgroup,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
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