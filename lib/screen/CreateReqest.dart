import 'package:blood_donation_fyp/widgets/InputField.dart';
import 'package:blood_donation_fyp/widgets/mainbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Models/BloodRequest.dart';
import '../constants/constant.dart';
import '../widgets/textwidget.dart';

class CreateRequest extends StatefulWidget {
  const CreateRequest({Key? key}) : super(key: key);

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {

  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
  final _hospitalController = TextEditingController();
  final _bloodTypeController = TextEditingController();
  final _mobileController = TextEditingController();
  final _noteController = TextEditingController();

  Future<String> generateRequestId() async {
    CollectionReference reference = FirebaseFirestore.instance.collection('requests');
    DocumentReference docRef = await reference.add(Map<String, dynamic>());
    return docRef.id;
  }


  String? _selectedBloodType; // To store the selected blood type
  List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ]; // List of blood types

  String? _selectedCity; // To store the selected city
  String _defaultCity = 'Select City'; // Default city
  List<String> pakistaniCities = [
    'Abbottabad',
    'Bahawalpur',
    'Bhalwal',
    'Charsadda',
    'Chaman',
    'Chiniot',
    'Daska',
    'Dera Ghazi Khan',
    'Dera Ismail Khan',
    'Faisalabad',
    'Gojra',
    'Gujranwala',
    'Gujrat',
    'Gwadar',
    'Hub',
    'Islamabad',
    'Jacobabad',
    'Jalalpur',
    'Jhang',
    'Jhelum',
    'Karachi',
    'Kasur',
    'Khairpur',
    'Khuzdar',
    'Kohat',
    'Lahore',
    'Larkana',
    'Mandi Bahauddin',
    'Mardan',
    'Mingora',
    'Mirpur',
    'Multan',
    'Muzaffarabad',
    'Nawabshah',
    'Nowshera',
    'Okara',
    'Peshawar',
    'Quetta',
    'Rahim Yar Khan',
    'Rawalpindi',
    'Sadiqabad',
    'Sahiwal',
    'Sargodha',
    'Sheikhupura',
    'Shikarpur',
    'Sialkot',
    'Sukkur',
    'Swabi',
    'Wah Cantonment',
  ];

// Function to get the current user's ID
  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null ? user.uid : '';
  }

  // Function to handle form submission
  Future<void> _submitForm() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {

      String requestId = await generateRequestId(); // Generate request ID
      String uid = getCurrentUserId(); // Get current user ID

      BloodRequest newRequest = BloodRequest(
        requestId: requestId,
        // Replace with your own logic to generate request ID
        uid: uid,
        // Replace with the actual user ID
        city: _selectedCity!,
        hospital: _hospitalController.text,
        bloodType: _selectedBloodType!,
        mobile: _mobileController.text,
        note: _noteController.text,
        status: 'pending',
        acceptingUserUid: '',
      );

      addBloodRequest(newRequest).then((_) {
        setState(() {
          loading = false;
        });

        clearFields();
        showDialog(
          context: context,
          builder: (_) => Dialog(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Image.asset(
                  "images/pana.png",
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                        text: 'Blood is successfully',
                        fontSize: 18,
                        color: knormalText),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                        text: 'requested.', fontSize: 18, color: knormalText),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 23.h),
                  child: MainButton(
                    width: 180.w,
                    fillColor: kmaincolor,
                    buttonText: 'Close',
                    buttonTextColor: kwhite,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ]),
            ),
          ),
        );
      });
    }
  }

  // Add a new blood request to the Firestore
  Future<void> addBloodRequest(BloodRequest request) async {
    CollectionReference requests =
        FirebaseFirestore.instance.collection('requests');
    await requests.doc(request.requestId).set(request.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 38),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.grey, // Replace with your color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.black, // Replace with your color
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 29),
                        child: Text(
                          'Post Request',
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.black), // Replace with your color
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 120),
                DropdownButtonFormField<String>(
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: kmaincolor,
                    ),
                    hintText: _defaultCity, // Use the default city as hint text
                  ),
                  value: _selectedCity, // Initially selected value (can be null)
                  items: pakistaniCities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCity = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty || value == _defaultCity) {
                      return 'Select Your City';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _hospitalController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Hospital',
                    prefixIcon: Icon(
                      Icons.home_work_outlined,
                      color: kmaincolor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 20.0,),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.water_drop_outlined,
                      color: kmaincolor,
                    ),
                    hintText: 'Select Blood Type',
                  ),
                  value: _selectedBloodType, // Initially selected value (can be null)
                  items: _bloodTypes.map((String bloodType) {
                    return DropdownMenuItem<String>(
                      value: bloodType,
                      child: Text(bloodType),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedBloodType = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select Your Blood Type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),


                TextFormField(

                  controller: _mobileController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(

                    hintText: 'Mobile',
                    prefixIcon: Icon(
                      Icons.phone,
                      color: kmaincolor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 100,
                  child: TextFormField(
                    controller: _noteController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Add note',
                      prefixIcon: Icon(
                        Icons.note_outlined,
                        color: kmaincolor,
                      ),
                    ),
                  ),
                ),
                loading ? CircularProgressIndicator() : MainButton(
                  width: 185.w,
                  buttonText: 'Post',
                  buttonTextColor: Colors.white,
                  fillColor: kmaincolor,
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearFields() {
    _selectedBloodType =  null;
    _selectedCity = null;
    _cityController.clear();
    _hospitalController.clear();
    _bloodTypeController.clear();
    _mobileController.clear();
    _noteController.clear();

  }
}
