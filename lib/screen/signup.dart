import 'package:blood_donation_fyp/screen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Models/User.dart';
import '../services/auth.dart';
import '../widgets/textformfield.dart';
import '/constants/constant.dart';
import '/widgets/textwidget.dart';
import '/widgets/mainbutton.dart';
import 'Bottom_Navigation_Bar.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _bloodGroupController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  bool loading = false;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Stack(
                children: [
                  Image.asset(
                    'images/vector_red.png',
                    width: 68.w,
                    height: 102.h,
                  ),
                  Positioned(
                    top: 35,
                    bottom: 40,
                    right: 30,
                    left: 20,
                    child: Image.asset(
                      'images/vector_red.png',
                      width: 10.w,
                      height: 15.h,
                    ),
                  ),
                  Positioned(
                    top: 55,
                    bottom: 20,
                    right: 10,
                    left: 40,
                    child: Image.asset(
                      'images/vector_red.png',
                      width: 10.w,
                      height: 15.h,
                    ),
                  ),
                  Positioned(
                    top: 65,
                    bottom: 10,
                    right: 30,
                    left: 20,
                    child: Image.asset(
                      'images/vector_red.png',
                      width: 10.w,
                      height: 15.h,
                    ),
                  ), //
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  const Spacer(
                    flex: 4,
                  ),
                  TextWidget(text: 'Dare', fontSize: 25, color: kmaincolor),
                  const Spacer(),
                  TextWidget(text: 'To', fontSize: 25, color: kheading),
                  const Spacer(),
                  TextWidget(text: 'Donate', fontSize: 25, color: kmaincolor),
                  const Spacer(
                    flex: 4,
                  ),
                ],
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    TextFormField(
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.person_2_outlined,
                          color: kmaincolor,
                        ),
                        hintText: 'Faiz Ali',
                      ),
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Your Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: kmaincolor,
                        ),
                        hintText: 'faizali@gmail.com',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Your Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: kmaincolor,
                        ),
                        hintText: 'Enter Password',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                        hintStyle:
                        TextStyle(fontSize: 20.0, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: kmaincolor,
                        ),
                        hintText: 'Confirm Password',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm Password is required';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: kmaincolor,
                        ),
                        hintText: '+923121232333',
                      ),
                      keyboardType: TextInputType.number,
                      controller: _phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Your Phone Number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    DropdownButtonFormField<String>(
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
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
                    SizedBox(height: 10.h),
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
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              loading
                  ? CircularProgressIndicator()
                  : MainButton(
                      buttonText: 'REGISTER',
                      buttonTextColor: kwhite,
                      fillColor: kmaincolor,
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          UserModel user = UserModel(
                            uid: '',
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            phone: _phoneController.text,
                            bloodGroup:_selectedBloodType!,
                            location: _selectedCity!,
                          );

                          bool res = await signUpWithEmailAndPassword(user);

                          if (res) {
                            res = await signInWithEmailAndPassword(
                                _emailController.text, _passwordController.text);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("User registered, welcome"),
                            ));

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavigationBarMenu(),
                              ),
                            );
                          }else{
                            ScaffoldMessenger.of(context)
                                .showSnackBar( SnackBar(
                              content: Text(resposne),
                            ));
                          }
                          setState(() {
                            loading = false;
                          });
                          clearFields();
                        }
                      },
                    ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  TextWidget(
                    text: 'Already have an account? ',
                    fontSize: 18,
                    color: knormalText,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: TextWidget(
                      text: 'Log in',
                      fontSize: 18,
                      color: kmaincolor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();

    _bloodGroupController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void clearFields() {
    setState(() {
      _selectedBloodType =  null;
      _selectedCity = null;

      _confirmPasswordController.clear();
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _phoneController.clear();
      _bloodGroupController.clear();
      _locationController.clear();
    });
  }
}
