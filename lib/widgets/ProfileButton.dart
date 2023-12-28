import 'package:blood_donation_fyp/Models/User.dart';
import 'package:blood_donation_fyp/screen/ChatDetailScreen.dart';
import 'package:blood_donation_fyp/screen/chatscreen.dart';
import 'package:blood_donation_fyp/screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final String uid;
  final String requestID;


  const ProfileButton({
    required this.text,
    required this.icon,
    required this.color,
    required this.phoneNumber,
    required this.uid,
    required this.requestID,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        if (text == 'Call Now') {
          _makePhoneCall('$phoneNumber');
        } else if (text == 'Request') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Request Clicked"),
          ));
        }else if (text == 'Donate') {
          await updateBloodRequestStatus(uid,requestID, 'approved');

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Thank you for accepting request"),
          ));
          Navigator.pop(context);
        }else if (text == 'Chat') {
          createChatBetweenUsers(uid);
          UserModel userModel = await fetchUser(uid);
          ChatUser user = ChatUser(uid:uid, username: userModel.name, avatar: userModel.image!, lastText: '');
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatDetailScreen(user: user)));

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
Future<void> updateBloodRequestStatus(String uid, String requestId, String newStatus) async {
  CollectionReference requests = FirebaseFirestore.instance.collection('requests');

  try {
    // Query for the specific blood request based on uid and requestId
    QuerySnapshot<Object?> querySnapshot = await requests
        .where('requestId', isEqualTo: requestId)
        .limit(1)
        .get();

    // Check if the document exists
    if (querySnapshot.docs.isNotEmpty) {
      String documentId = querySnapshot.docs.first.id;

      // Update the status of the blood request
      await requests.doc(documentId).update({'status': newStatus, 'acceptingUserUid':uid});
      print('Blood request status updated successfully');
    } else {
      print('Blood request not found with specified uid and requestId');
    }
  } catch (e) {
    print('Error updating blood request status: $e');
  }
}



void createChatBetweenUsers(String uid) async {
  String user1ID = getCurrentUserId();

  String chatID = getChatID(user1ID, uid);

  await FirebaseFirestore.instance.collection('chats').doc(chatID).set({
    'user1ID': user1ID,
    'user2ID': uid,
  });
}
String getChatID(String userID1, String userID2) {
  List<String> sortedUserIDs = [userID1, userID2]..sort();
  return sortedUserIDs.join('_');
}