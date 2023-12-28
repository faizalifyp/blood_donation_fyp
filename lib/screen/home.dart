import 'dart:developer';

import 'package:blood_donation_fyp/constants/constant.dart';
import 'package:blood_donation_fyp/screen/CreateReqest.dart';
import 'package:blood_donation_fyp/screen/DonationRequest.dart';
import 'package:blood_donation_fyp/screen/FindDonors.dart';
import 'package:blood_donation_fyp/screen/OrderBlood.dart';
import 'package:blood_donation_fyp/screen/Report.dart';
import 'package:blood_donation_fyp/widgets/HomePageButtons.dart';
import 'package:blood_donation_fyp/widgets/textwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Models/BloodRequest.dart';
import '../Models/DonationRequestList.dart';
import '../widgets/DonateTile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 35.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      const Icon(Icons.notifications_outlined, color: kheading,size: 30,),
                      Positioned(
                        top: 5.h,
                        right: 3.w,
                        left: 17.w,
                        child: Container(
                          height: 10.h,
                          width: 10.w,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                          color: kmaincolor),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            SizedBox(height: 20.h,),
            SizedBox(
              height: 180.h,
              child: PageView(
                controller: _controller,
                children: [
                  Container(

                    width: MediaQuery.of(context).size.width*1.1,
                    height: 170.h,
                    decoration: BoxDecoration(
                      image:const  DecorationImage(
                          image: AssetImage('images/main_img.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(

                    width: MediaQuery.of(context).size.width*1.1,
                    height: 170.h,
                    decoration: BoxDecoration(
                      image:const  DecorationImage(
                          image: AssetImage('images/main_img.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(

                    width: MediaQuery.of(context).size.width*1.1,
                    height: 170.h,
                    decoration: BoxDecoration(
                      image:const  DecorationImage(
                          image: AssetImage('images/main_img.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(

                    width: MediaQuery.of(context).size.width*1.1,
                    height: 170.h,
                    decoration: BoxDecoration(
                      image:const  DecorationImage(
                          image: AssetImage('images/main_img.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h,),
            SmoothPageIndicator(
              controller: _controller,
              count: 4,
              effect: ScrollingDotsEffect(
                activeDotColor: kmaincolor,
                dotColor: knormalText,
                dotHeight: 10.h,
                dotWidth: 10.w,
                spacing: 16.w,
              ),
            ),

            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const FindDonors()));
                        },
                        child:const HomePageButtons(
                            imageAddress: 'images/ion_search-outline.png',
                            Text: 'Find Donors'),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const DonationRequestListScreen()));
                        },
                        child: const HomePageButtons(
                            imageAddress: 'images/blood-transfusion.png',
                            Text: 'Donates'),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Report()));
                        },
                        child: HomePageButtons(
                            imageAddress: 'images/report.png',
                            Text: 'Health Report'),
                      ),
                      // GestureDetector(
                      //   onTap: (){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const OrderBlood()));
                      //   },
                      //   child: const HomePageButtons(
                      //       imageAddress: 'images/blood-bag.png',
                      //       Text: 'Order Bloods'),
                      // ),

                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  [
                      // HomePageButtons(
                      //     imageAddress: 'images/maki_doctor.png',
                      //     Text: 'Assistant'),

                      // GestureDetector(
                      //   onTap: (){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const Compagin()));
                      //   },
                      //   child: HomePageButtons(
                      //       imageAddress: 'images/compagin.png',
                      //       Text: 'Compagin'),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
                    child: TextWidget(
                        text: 'Your Requests',
                        fontSize: 18,
                        color: kheading,
                      weight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(
                    height: 400, // Adjust the height as needed
                    child: buildBloodRequestList(),
                  ),                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}

// Implement ListView.builder to display the list of blood requests
StreamBuilder<List<BloodRequest>> buildBloodRequestList() {
  return StreamBuilder<List<BloodRequest>>(
    stream: fetchBloodRequestsByCurrentUser(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<BloodRequest>? bloodRequestList = snapshot.data;
        print("length: ${bloodRequestList!.length}");
        print('Blood request list from snapshot: $bloodRequestList');

        return ListView.builder(
          itemCount: bloodRequestList!.length,
          itemBuilder: (context, index) {
            print('Building DonateTile for index $index');
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: BloodRequestTile(
                hospitalName: bloodRequestList[index].hospital,
                city: bloodRequestList[index].city,
                status: bloodRequestList[index].status,
                bloodGroup: bloodRequestList[index].bloodType,
              ),
            );
          },
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return  Container(child: const Center(child: CircularProgressIndicator())); // or any loading indicator widget
      }
    },
  );
}

Future<int> countDocuments() async {
  CollectionReference requests = FirebaseFirestore.instance.collection('requests');
  QuerySnapshot querySnapshot = await requests.get();
  int count = querySnapshot.docs.length;
  log("count : "+ count.toString());

  return count;
}
// Function to fetch all blood requests made by the current user in real time
// Function to fetch all blood requests made by the current user in real time
Stream<List<BloodRequest>> fetchBloodRequestsByCurrentUser() {
  String currentUserId = getCurrentUserId();
  CollectionReference requests = FirebaseFirestore.instance.collection('requests');

  return requests.where('uid', isEqualTo: currentUserId).snapshots().map((snapshot) {
    print('Snapshot data: ${snapshot.docs}');
    List<BloodRequest> requestsList = snapshot.docs.map((doc) {
      print('Document data: ${doc.data()}');
      BloodRequest bloodRequest = BloodRequest(
        requestId: doc['requestId'],
        uid: doc['uid'],
        city: doc['city'],
        hospital: doc['hospital'],
        bloodType: doc['bloodType'],
        mobile: doc['mobile'],
        note: doc['note'],
        status: doc['status'],
        acceptingUserUid: doc['acceptingUserUid'],
      );
      print('Blood request: $bloodRequest');
      return bloodRequest;
    }).toList();
    print('Blood request list: $requestsList');
    return requestsList;
  });
}

// Function to get the current user's ID
String getCurrentUserId() {

  User? user = FirebaseAuth.instance.currentUser;
  return user != null ? user.uid : '';
}