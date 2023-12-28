import 'dart:developer';

import 'package:blood_donation_fyp/Models/DonarsDetails.dart';
import 'package:blood_donation_fyp/services/auth.dart';
import 'package:blood_donation_fyp/widgets/ProfileButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Models/User.dart';
import '../constants/constant.dart';
import '../widgets/ProfileInfo.dart';
import '../widgets/textwidget.dart';
import 'loginscreen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool loading = true;

  UserModel userModel = UserModel(
    uid: '',
    name: '',
    email: '',
    password: '',
    phone: '',
    bloodGroup: '',
    location: '',
  );

  @override
  void initState() {
    super.initState();
    getUserDataFromFirestore(userId);

  }


  //
  Future<void> getUserDataFromFirestore(String uid) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming only one document will match the UID
        Map<String, dynamic>? data = querySnapshot.docs.first.data() as Map<String, dynamic>?;
        if (data != null) {
          // Handle the user data here
          log('User data: $data');
          // Create a UserModel object using the fetched data
          setState(() {
            userModel = UserModel.fromJson(data);
            loading = false;
          });



        } else {
          log('User data is null');
        }
      } else {
        log('No user found for the given UID.');
      }
    } catch (e) {
      log(e.toString());
    }
  }




  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          // mainAxisAlignment: MainAxisAlignment.s,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 38.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
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
                  TextWidget(
                    text: 'Profile',
                    fontSize: 22,
                    color: kheading,
                  ),
                  Icon(Icons.edit_calendar_sharp, color: knormalText,),
                ],
              ),
            ),
            SizedBox(height: 22.h,),
            Container(
              height: 89.54.h,
              width: 89.54.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(image: AssetImage(DonorsList[2].image), fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20.h,),
            TextWidget(
                text: loading ? "loading..." : userModel.name,
                fontSize: loading ? 16 : 30,
                color: kheading,
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined, color: kmaincolor,
                ),
                SizedBox(width: 10.w,),
                TextWidget(
                    text: loading ? "loading..." : userModel.location,
                    fontSize: loading ? 16 : 18,
                    color: knormalText,
                ),
              ],
            ),
            SizedBox(height: 15.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: ,
              children:  [
                ProfileButton(text: 'Call Now', icon: Icons.phone_outlined, color: kcallbuttoncolor,
                  phoneNumber: userModel.phone, // Replace with the desired phone number
                ),
                ProfileButton(text: 'Request', icon: Icons.arrow_back, color: kmaincolor,
                  phoneNumber: '', // Replace with the desired phone number
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            loading ? CircularProgressIndicator() : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileInfo(
                  bloodGroup:  userModel.bloodGroup,
                  bloodGrouptext: 'Blood Type',
                ),
                ProfileInfo(
                    bloodGroup:'${DonorsList[2].TimeDonated}',
                    bloodGrouptext: 'Donated',
                ),
                ProfileInfo(
                    bloodGroup:  '${DonorsList[2].Requested}',
                    bloodGrouptext: 'Requested',
                ),
              ],
            ),
            SizedBox(height: 25.h,),
            Container(
              width: 1.sw,
              height: 55.h,
              decoration: const BoxDecoration(
                color: kwhite,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 10,
                    color: Colors.black12,
                  )
                ]
              ),
              child: Row(
                children: [
                  Icon(Icons.date_range, color: kmaincolor,),
                  TextWidget(text: 'Available for donate', fontSize: 14, color: knormalText),

                ],
              ),
            ),
            Container(
              width: 1.sw,
              height: 55.h,
              decoration: const BoxDecoration(
                  color: kwhite,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 10,
                      color: Colors.black12,
                    )
                  ]
              ),
              child: Row(
                children: [
                  Icon(Icons.mail_outline_rounded, color: kmaincolor,),
                  TextWidget(text: 'Invite a friend', fontSize: 14, color: knormalText),

                ],
              ),
            ),
            Container(
              width: 1.sw,
              height: 55.h,
              decoration: const BoxDecoration(
                  color: kwhite,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 10,
                      color: Colors.black12,
                    )
                  ]
              ),
              child: Row(
                children: [
                  Icon(Icons.expand, color: kmaincolor,),
                  TextWidget(text: 'Get help', fontSize: 14, color: knormalText),

                ],
              ),
            ),
            Container(
              width: 1.sw,
              height: 55.h,
              decoration: const BoxDecoration(
                  color: kwhite,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 10,
                      color: Colors.black12,
                    )
                  ]
              ),
              child: Row(
                children: [
                  Icon(Icons.logout_outlined, color: kmaincolor,),
                  InkWell(onTap: (){
                    signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  }, child: TextWidget(text: 'Sign out', fontSize: 14, color: knormalText)),

                ],
              ),
            ),




          ],
        ),
      ),
    );
  }
}

