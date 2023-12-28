import 'dart:developer';

import 'package:blood_donation_fyp/screen/SingleDonorDetailScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Models/DonarsDetails.dart';
import '../Models/DonationRequestList.dart';
import '../Models/User.dart';
import '../constants/constant.dart';
import '../services/auth.dart';
import '../widgets/DonateTile.dart';
import '../widgets/DonorsDetailsCard.dart';
import '../widgets/textwidget.dart';

class FindDonors extends StatefulWidget {
  const FindDonors({Key? key}) : super(key: key);

  @override
  State<FindDonors> createState() => _FindDonorsState();
}

class _FindDonorsState extends State<FindDonors> {


  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void _settingModelBottomNaviation(UserModel user, String requestID){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        // clipBehavior: Clip.none,

        builder: (BuildContext context){

          return SingleDonorDetailScreen( user: user, request: false, requestID: requestID);
        });
  }




// Function to fetch all users from Firestore
  void fetchUsers() async {
    List<UserModel> fetchedUsers = await fetchAllUsers(await getCurrentUserId());
    setState(() {
      usersDonorsList = fetchedUsers;
    });
  }

  List<UserModel> filterUsers(String searchQuery) {
    return usersDonorsList.where((user) {
      return user.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          user.location.toLowerCase().contains(searchQuery.toLowerCase()) ||
          user.bloodGroup.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }


  Future<String> getCurrentUserId() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      return uid;
    } else {
      // Handle the case when the user is not signed in
      throw Exception('User is not signed in.');
    }
  }


  // void _settingModelBottomNaviation(int index){
  //   showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: true,
  //       backgroundColor: Colors.transparent,
  //       // clipBehavior: Clip.none,
  //
  //       builder: (BuildContext context){
  //
  //         return SingleDonorDetailScreen( index: index);
  //   });
  // }





  @override
  Widget build(BuildContext context) {

    List<UserModel> filteredUsers = filterUsers(searchQuery);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 40.h,),
            Padding(
              padding: EdgeInsets.only(top: 38.h),
              child: Row(
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
                  Padding(
                    padding: EdgeInsets.only(left: 79.w),
                    child: TextWidget(
                      text: 'Find Donors',
                      fontSize: 22,
                      color: kheading,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50.h,
                  width: 350.w,
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
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),


              ],

            ),

            Expanded(
              child: FutureBuilder(
                future: fetchAllUsers(getCurrentUserId().toString()),
                builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(), // Show a circular loader
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {

                          return GestureDetector(
                            onTap: () {
                              _settingModelBottomNaviation(filteredUsers[index],'' );
                            },
                            child: DonorDetailsCard(
                              name: filteredUsers[index].name,
                              location: filteredUsers[index].location,
                              image: filteredUsers[index].image!,
                              bloodgroup: filteredUsers[index].bloodGroup,
                            ),
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


