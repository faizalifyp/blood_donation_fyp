import 'package:blood_donation_fyp/constants/constant.dart';
import 'package:blood_donation_fyp/widgets/textwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Models/BloodRequest.dart';
import '../Models/DonationRequestList.dart';
import '../Models/User.dart';
import '../services/blood_requests.dart';
import '../widgets/DonateTile.dart';
import 'SingleDonorDetailScreen.dart';

class DonationRequestListScreen extends StatefulWidget {
  const DonationRequestListScreen({Key? key}) : super(key: key);

  @override
  State<DonationRequestListScreen> createState() =>
      _DonationRequestListScreenState();
}

class _DonationRequestListScreenState extends State<DonationRequestListScreen> {
  late Stream<List<BloodRequest>> bloodRequestsStream;

  @override
  void initState() {
    super.initState();
    bloodRequestsStream = getBloodRequestsStream(); // Replace with your Firebase stream function
  }
  void settingModelBottomNaviation(UserModel user, String requestID){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        // clipBehavior: Clip.none,

        builder: (BuildContext context){

          return SingleDonorDetailScreen( user: user, request: true, requestID: requestID);
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 38.h),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: GestureDetector(
                    onTap: () {
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
                          Icons.arrow_back_ios_new_outlined,
                          color: kheading,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 29.w),
                  child: TextWidget(
                    text: 'Donation Request',
                    fontSize: 22,
                    color: kheading,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<BloodRequest>>(
              stream: bloodRequestsStream,
              builder: (context, snapshot) {

                List<BloodRequest> donationRequestList = snapshot.data ?? [];

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: donationRequestList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: InkWell(
                        onTap: () async {
                          List<UserModel> users = await fetchUser(donationRequestList[index].uid);
                          settingModelBottomNaviation(users[0], donationRequestList[index].requestId);

                        },
                        child: BloodRequestTile(
                          hospitalName: donationRequestList[index].hospital,
                          city: donationRequestList[index].city,
                          status: donationRequestList[index].status,
                          bloodGroup: donationRequestList[index].bloodType,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


Future<List<UserModel>> fetchUser(String currentUserId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot = await firestore.collection('users').get();
  List<UserModel> users = querySnapshot.docs.map((doc) {
    return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  }).toList();

  // Filtering out the current user based on their ID
  users.removeWhere((user) => user.uid != currentUserId);

  return users;
}

void showAcceptRejectDialog(BuildContext context, String requestId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Accept or Reject Request'),
        content: Text('Do you want to accept or reject this blood request?'),
        actions: <Widget>[
          TextButton(
            child: Text('Reject'),
            onPressed: () {
              Navigator.of(context).pop();
              rejectBloodRequest(requestId); // Call the reject function here
            },
          ),
          TextButton(
            child: Text('Accept'),
            onPressed: () {
              Navigator.of(context).pop();
              String acceptingUserUid =
                  'user123'; // Replace with the accepting user's UID
              acceptBloodRequest(
                  requestId, acceptingUserUid); // Call the accept function here
            },
          ),
        ],
      );
    },
  );
}
