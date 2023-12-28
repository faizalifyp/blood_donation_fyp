import 'package:blood_donation_fyp/screen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Models/User.dart';
import '../services/auth.dart';
import '../widgets/textformfield.dart';
import '/constants/constant.dart';
import '/widgets/textwidget.dart';
import '/widgets/mainbutton.dart';


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
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _bloodGroupController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  bool loading = false;

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
                  Image.asset('images/vector_red.png',width: 68.w,height: 102.h,),
                  Positioned(
                    top: 35,
                    bottom: 40,
                    right: 30,
                    left: 20,
                    child:
                    Image.asset('images/vector_red.png', width: 10.w,height: 15.h,),
                  ),
                  Positioned(
                    top: 55,
                    bottom: 20,
                    right: 10,
                    left: 40,
                    child: Image.asset('images/vector_red.png',width: 10.w,height: 15.h,),
                  ),
                  Positioned(

                    top: 65,
                    bottom: 10,
                    right: 30,
                    left: 20,
                    child: Image.asset('images/vector_red.png',width: 10.w,height: 15.h,),
                  ),  //
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                children: [
                  const Spacer(flex: 4,),
                  TextWidget(text: 'Dare', fontSize: 25, color: kmaincolor),
                  const Spacer(),
                  TextWidget(text: 'To', fontSize: 25, color: kheading),
                  const Spacer(),
                  TextWidget(text: 'Donate', fontSize: 25, color: kmaincolor),
                  const Spacer(flex: 4,),
                ],
              ),
              Form(
                key: _formkey,
                  child:
              Column(
                children: [
                  SizedBox(height: 30.h),
                  Textformfield(
                    controller: _nameController,
                    hintText: 'Faiz Ali',
                      obsecureText: false,
                      keybordtype: TextInputType.name,
                      icon: Icons.person_2_outlined,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  Textformfield(
                    controller: _emailController,
                    hintText: 'faizali@gmail.com',
                    obsecureText: false,
                    keybordtype: TextInputType.emailAddress,
                    icon: Icons.email_outlined,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  Textformfield(
                    controller: _passwordController,
                    hintText: '***********',
                    obsecureText: true,
                    keybordtype: TextInputType.visiblePassword,
                    icon: Icons.lock_outline,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  Textformfield(
                    controller: _phoneController,
                    hintText: '+923121232333',
                    obsecureText: false,
                    keybordtype: TextInputType.number,
                    icon: Icons.phone_outlined,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Phone Number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  Textformfield(
                    controller: _bloodGroupController,
                    hintText: 'O+',
                    obsecureText: false,
                    keybordtype: TextInputType.name,
                    icon: Icons.water_drop_outlined,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Blood Group';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  Textformfield(
                    controller: _locationController,
                    hintText: 'Lahore, Punjab',
                    obsecureText: false,
                    keybordtype: TextInputType.name,
                    icon: Icons.location_on_outlined,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Select Your Location';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              ),
              SizedBox(height: 20.h),
              loading ? CircularProgressIndicator() : MainButton(
                  buttonText: 'REGISTER',
                  buttonTextColor: kwhite,
                  fillColor: kmaincolor,
                onPressed: () async{
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
                      bloodGroup: _bloodGroupController.text,
                      location: _locationController.text,
                    );

                    await signUpWithEmailAndPassword(user);
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
                    onTap: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context)=>const LoginScreen(),
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
    _passwordController.dispose();
    _phoneController.dispose();
    _bloodGroupController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void clearFields() {
   setState(() {
     _nameController.clear();
     _emailController.clear();
     _passwordController.clear();
     _phoneController.clear();
     _bloodGroupController.clear();
     _locationController.clear();
   });
  }

}
