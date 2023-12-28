


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';
import 'textwidget.dart';

import 'package:url_launcher/url_launcher.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final String phoneNumber;

  const ProfileButton({
    required this.text,
    required this.icon,
    required this.color,
    required this.phoneNumber, // Add the phone number here
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (text == 'Call Now') {
          _makePhoneCall('$phoneNumber');
        } else if (text == 'Request') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Request Clicked"),
          ));

        }
      },
      child: Container(
        width: 158.w,
        height: 52.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, color: kwhite),
            TextWidget(text: text, fontSize: 16.sp, color: kwhite),
          ],
        ),
      ),
    );
  }

  // Function to initiate a phone call
  Future<void> _makePhoneCall(String phoneNumber) async {


    String url = 'tel://$phoneNumber';
    launch(url);


  }

}
