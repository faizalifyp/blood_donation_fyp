
import '/constants/constant.dart';
import '/screen/Profile.dart';
import '/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'CreateReqest.dart';
import 'chatscreen.dart';

class BottomNavigationBarMenu extends StatefulWidget {
  const BottomNavigationBarMenu({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarMenu> createState() => _BottomNavigationBarMenuState();
}

class _BottomNavigationBarMenuState extends State<BottomNavigationBarMenu> {
  // bool home = true;
  // bool search = false;
  // bool compagin = false;
  // bool profile = false;


  int _selectedIndex = 0;
  final List<Widget> _widgetlist = [
     const Home(),
     const ChatScreen(),
    const CreateRequest(),
    const ProfileScreen(),
     // TextWidget(text: 'Profile', fontSize: 45, color: Colors.black),// const Text('Tickets'),
    // const Text('Profile'),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

       Center(
         child:  _widgetlist[_selectedIndex],
       ),


      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              decoration: const BoxDecoration(
               // color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 15
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BottomNavigationBar(
                  onTap: _onItemTapped,
                  currentIndex: _selectedIndex,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  backgroundColor: Colors.white,
                  selectedItemColor: kmaincolor,
                  unselectedItemColor: knormalText,
                  // elevation: 10,
                  iconSize: 30,
                  type: BottomNavigationBarType.fixed,
                  items:  <BottomNavigationBarItem>[
                      const BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: "Home",
                    ),
                     const BottomNavigationBarItem(
                      icon: Icon(Icons.chat),
                      label: "Chat",
                    ),
                     BottomNavigationBarItem(
                       icon: Transform.rotate(
                         angle: 120 * math.pi/180,
                         child: const Icon(Icons.electric_bolt),
                       ),
                       label: 'Compagin',
                     ),
                     const BottomNavigationBarItem(
                      icon: Icon(Icons.person_2_outlined),
                      label: "Profile",
                    ),
                  ],


                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
