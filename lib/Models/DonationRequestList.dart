import 'package:blood_donation_fyp/Models/BloodRequest.dart';

import '../services/blood_requests.dart';

class DonationRequest{
  String name;
  String location;
  String bloodGroupType;
  int time;
  DonationRequest({required this.name,required this.location,required this.bloodGroupType, required this.time,});
}

