import 'package:blood_donation_fyp/constants/constant.dart';
import 'package:blood_donation_fyp/widgets/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Models/BloodRequest.dart';
import '../Models/DonationRequestList.dart';
import '../services/blood_requests.dart';
import '../widgets/DonateTile.dart';

class DonationRequestListScreen extends StatelessWidget {
  const DonationRequestListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BloodRequest> donationRequestList =  fetchAllBloodRequests() as List<BloodRequest>;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 38.h),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w
                  , right: 20.w),
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
                    text: 'Donation Request',
                    fontSize: 22,
                    color: kheading,
                  ),
                ),
              ],
            ),
          ),
          Container(

            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: donationRequestList.length,
                  itemBuilder: (context, index){
                return Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: InkWell(
                    onTap: (){
                      showAcceptRejectDialog(context,donationRequestList[index].toString());
                    },
                    // child: BloodRequestTile(
                    //   hospitalName: donationRequestList[index].name,
                    //   city: donationRequestList[index].location,
                    //   status: donationRequestList[index].time.toString(),
                    //   bloodGroup: donationRequestList[index].bloodGroupType,
                    // ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
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
              String acceptingUserUid = 'user123'; // Replace with the accepting user's UID
              acceptBloodRequest(requestId, acceptingUserUid); // Call the accept function here
            },
          ),
        ],
      );
    },
  );
}
