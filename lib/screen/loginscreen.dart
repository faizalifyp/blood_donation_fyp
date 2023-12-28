

import 'dart:developer';

import '../services/auth.dart';
import 'Bottom_Navigation_Bar.dart';
import 'home.dart';
import 'reset_password.dart';
import 'package:blood_donation_fyp/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/textformfield.dart';
import '/constants/constant.dart';
import '/widgets/textwidget.dart';
import '/widgets/mainbutton.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> _formkey =  GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 70.h,
                ),
                Stack(
                  children: [
                    Image.asset('images/vector_red.png',width: 68.w,height: 102.h,),
                    Positioned(
                      top: 35,
                      bottom: 40,
                      right: 30,
                      left: 20,
                      child:
                      Container(
                        child: Image.asset('images/vector_red.png', width: 10.w,height: 15.h,),
                      ),
                    ),
                    Positioned(
                      top: 55,
                      bottom: 20,
                      right: 10,
                      left: 40,
                      child: Container(
                        child: Image.asset('images/vector_red.png',width: 10.w,height: 15.h,),

                      ),
                    ),
                    Positioned(

                      top: 65,
                      bottom: 10,
                      right: 30,
                      left: 20,
                      child: Container(
                      child: Image.asset('images/vector_red.png',width: 10.w,height: 15.h,),
                      ),
                    ),  //
                  ],
                ),
                SizedBox(height: 8.h,),
                Row(
                  children: [
                    Spacer(flex: 4,),
                    TextWidget(text: 'Dare', fontSize: 25, color: kmaincolor),
                    Spacer(),
                    TextWidget(text: 'To', fontSize: 25, color: kheading),
                    Spacer(),
                    TextWidget(text: 'Donate', fontSize: 25, color: kmaincolor),
                    Spacer(flex: 4,),
                  ],
                ),
                SizedBox(height: 120.h,),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
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


                        controller : _emailController,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                            return 'Invalid email';
                          }
                          // print(value);
                          return null;
                        },



                        //value.isEmpty ? "Email cannot be empty" : null,


                      ),
                      SizedBox(height: 25.h,),
                      TextFormField(
                        obscureText: true,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          decoration: InputDecoration(

                            hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: kmaincolor,
                            ),
                            hintText: '***********',
                          ),
                          controller : _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            // print(value);
                            return null;
                          },

                          keyboardType: TextInputType.visiblePassword,
                          ),
                    ],
                  ),
                ),

                SizedBox(height: 85.h,),
                loading ? CircularProgressIndicator() : MainButton(
                    buttonText: 'LOG IN',
                    buttonTextColor: kwhite,
                  onPressed: () async {

                    if(_formkey.currentState!.validate()){
                      _formkey.currentState!.save();

                      setState(() {
                        loading = true;
                      });


                      bool res = await signInWithEmailAndPassword(_emailController.text, _passwordController.text);

                      if(res){

                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                          content: Text(resposne),
                        ));

                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const BottomNavigationBarMenu(),
                          ),
                        )  ;
                      }else{

                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                          content: Text(resposne),
                        ));
                      }
                      setState(() {
                        loading = false;

                      });

                    }
                  },
                  fillColor: kmaincolor,
                ),
                SizedBox(height: 15.h,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResetPassword(),),);
                  },
                  child: TextWidget(
                      text: 'Forgot Password?',
                      fontSize: 18.sp,
                      color: kmaincolor,
                  ),
                ),
                SizedBox(height: 50.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                        text: 'Don’t have an account? ',
                        fontSize: 16.sp,
                        color: knormalText,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context)=>SignUp(),
                          ),
                        );
                      },
                      child: TextWidget(
                          text: ' Register Now.',
                          fontSize: 16.sp,
                          color: kmaincolor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {


    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

}

