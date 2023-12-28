import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:blood_donation_fyp/Models/DonarsDetails.dart';
import 'package:blood_donation_fyp/services/auth.dart';
import 'package:blood_donation_fyp/widgets/ProfileButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Reference _storage = FirebaseStorage.instance.ref();

  XFile? _image;

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  bool _isUploading = false;

  Future<void> uploadPic(BuildContext context) async {
    await getImage();

    String uid = _auth.currentUser?.uid ?? "";
    String filePath = 'profile_images/$uid.png';

    try {
      setState(() {
        _isUploading = true;
      });

      List<int> imageBytes = await _image!.readAsBytes();
      Uint8List uint8List = Uint8List.fromList(imageBytes);

      await _storage.child(filePath).putData(uint8List);
      String downloadURL = await _storage.child(filePath).getDownloadURL();

      // Get the user document based on the UID property
      QuerySnapshot<Map<String, dynamic>> userQuery = await _firestore
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      if (userQuery.docs.isNotEmpty) {
        String documentId = userQuery.docs.first.id;

        await _firestore.collection('users').doc(documentId).update({
          'profileImageUrl': downloadURL,
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Profile Picture Uploaded"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error uploading picture")));
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  // Add this function to your class
  Future<String?> getProfileImageUrl() async {
    String uid = await _auth.currentUser?.uid ?? "";

    try {
      QuerySnapshot<Map<String, dynamic>> userQuery = await _firestore
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      if (userQuery.docs.isNotEmpty) {
        Map<String, dynamic> userData = userQuery.docs.first.data();
        return userData['profileImageUrl'];
      } else {
        print("User with UID $uid not found");
        return null;
      }
    } catch (e) {
      print("Error fetching profile image URL: $e");
      return null;
    }
  }

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
        Map<String, dynamic>? data =
            querySnapshot.docs.first.data() as Map<String, dynamic>?;
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    text: 'Profile',
                    fontSize: 24,
                    color: kheading,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            FutureBuilder<String?>(
              future: getProfileImageUrl(),
              builder: (context, snapshot) {
                if (_isUploading) {
                  return CircularProgressIndicator();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data != null) {
                  return CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(snapshot.data!),
                  );
                } else {
                  return GestureDetector(
                    onTap: () async {
                      await uploadPic(context);
                    },
                    child: _image != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(File(_image!.path)),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("images/avatar.png"),
                          ),
                  );
                }
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            TextWidget(
              text: loading ? "loading..." : userModel.name,
              fontSize: loading ? 16 : 30,
              color: kheading,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: kmaincolor,
                ),
                SizedBox(
                  width: 10.w,
                ),
                TextWidget(
                  text: loading ? "loading..." : userModel.location,
                  fontSize: loading ? 16 : 18,
                  color: knormalText,
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: ,
              children: [
                ProfileButton(
                  uid: '',
                  requestID: '',
                  text: 'Call Now',
                  icon: Icons.phone_outlined,
                  color: kcallbuttoncolor,
                  phoneNumber:
                      userModel.phone, // Replace with the desired phone number
                ),
                ProfileButton(
                  uid: '',
                  requestID: '',
                  text: 'Request',
                  icon: Icons.arrow_back,
                  color: kmaincolor,
                  phoneNumber: '', // Replace with the desired phone number
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            loading
                ? CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfileInfo(
                        bloodGroup: userModel.bloodGroup,
                        bloodGrouptext: 'Blood Type',
                      ),
                      ProfileInfo(
                        bloodGroup: '${DonorsList[2].TimeDonated}',
                        bloodGrouptext: 'Donated',
                      ),
                      ProfileInfo(
                        bloodGroup: '${DonorsList[2].Requested}',
                        bloodGrouptext: 'Requested',
                      ),
                    ],
                  ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              width: 1.sw,
              height: 55.h,
              decoration: const BoxDecoration(color: kwhite, boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 10,
                  color: Colors.black12,
                )
              ]),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.phone,
                    color: kmaincolor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextWidget(
                      text: userModel.phone, fontSize: 16, color: knormalText),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 1.sw,
              height: 55.h,
              decoration: const BoxDecoration(color: kwhite, boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 10,
                  color: Colors.black12,
                )
              ]),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.email,
                    color: kmaincolor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextWidget(
                      text: userModel.email, fontSize: 16, color: knormalText),
                ],
              ),
            ),
            SizedBox(
              height: 10,
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
                ],
              ),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Icon(
                    Icons.logout_outlined,
                    color: kmaincolor,
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      _showSignOutConfirmationDialog(context);
                    },
                    child: TextWidget(
                      text: 'Sign out',
                      fontSize: 16,
                      color: knormalText,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _showSignOutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentTextStyle: TextStyle(color: Colors.black),
        titleTextStyle: TextStyle(color: kmaincolor),
        title: Text('Sign Out'),
        content: Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              signOut(); // Perform sign-out
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: Text('Sign Out'),
          ),
        ],
      );
    },
  );
}
