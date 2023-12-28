import 'User.dart';

class DonorDetails{
  String Name;
  String Place;
  String image;
  String BloodGroup;
  int TimeDonated;
  int Requested;
  int PhoneNumber;

  DonorDetails({
    required this.Name,
    required this.Place,
    required this.image,
    required this.BloodGroup,
    required this.TimeDonated,
    required this.Requested,
    required this.PhoneNumber,

  });
}




List<UserModel> usersDonorsList = []; // Initialize an empty list


List<DonorDetails> DonorsList = [
  DonorDetails(
      Name: 'Yasin Hossain',
      Place: 'Mohammedpur, Dhaka',
      image: 'images/DonorProfileImage/1.png',
      BloodGroup: 'A+',
    TimeDonated: 3,
    Requested: 4,
    PhoneNumber: 12345678,
  ),
  DonorDetails(
      Name: 'Mohammed Sami',
      Place: 'Mirpur 10, Dhaka',
    image: 'images/DonorProfileImage/2.png',
    BloodGroup: 'AB+',
    TimeDonated: 6,
    Requested: 2,
    PhoneNumber: 12345678,
  ),
  DonorDetails(
      Name: 'Rahimun Islam',
      Place: 'Chittagong',
      image: 'images/DonorProfileImage/3.png',
      BloodGroup: 'B-',
    TimeDonated: 1,
    Requested: 3,
    PhoneNumber: 12345678,
  ),
  DonorDetails(
      Name: 'Rumana',
      Place: 'Lakshmipur',
      image: 'images/DonorProfileImage/4.png',
      BloodGroup: 'O+',
    TimeDonated: 0,
    Requested: 6,
    PhoneNumber: 12345678,
  ),
  DonorDetails(
      Name: 'Jubayer Ahmed',
      Place: 'Mohammedpur, Dhaka',
      image: 'images/DonorProfileImage/5.png',
      BloodGroup: 'A+',
    TimeDonated: 9,
    Requested: 2,
    PhoneNumber: 12345678,
  ),
];