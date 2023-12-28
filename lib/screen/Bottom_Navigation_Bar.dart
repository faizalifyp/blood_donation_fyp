
import '/constants/constant.dart';
import '/screen/Profile.dart';
import '/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'CreateReqest.dart';
import 'OrderBlood.dart';

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
     const OrderBlood(),
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
      // bottomNavigationBar: ClipRRect(
      //   borderRadius: BorderRadius.circular(50),
      //   child: BottomNavigationBar(
      //     onTap: _onItemTapped,
      //     currentIndex: _selectedIndex,
      //    // fixedColor: Colors.blue,
      //     //elevation: 10,
      //     showSelectedLabels: false,
      //     showUnselectedLabels: false,
      //     type: BottomNavigationBarType.fixed,
      //     selectedItemColor: Colors.blueGrey,
      //     unselectedItemColor: const Color(0xFF526480),
      //     items:const [
      //       BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
      //       BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search'),
      //       BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket),label: 'Tickets'),
      //       BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
      //     ],
      //   ),
      // ),

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
                      icon: Icon(Icons.search),
                      label: "Search",
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
          Positioned(
            bottom: 40.h,
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.black12,
                    spreadRadius: 5,
                  ),
                ],
                // color: Colors.red,
                shape: BoxShape.circle,
                image: DecorationImage(

                  image: AssetImage("images/navigation_bar_blood_drop.png", ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),













      // bottomNavigationBar: SafeArea(
      //   child: Stack(
      //     alignment: AlignmentDirectional.bottomCenter,
      //
      //     children: [
      //
      //        Positioned(
      //          left: 20,
      //          right: 20,
      //          bottom: 10,
      //          // top: 30.h,
      //          // bottom: 10.h,
      //          child: Container(
      //            // padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
      //           width: double.infinity,
      //           height: 70.h,
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(20.0),
      //             boxShadow: const [
      //               BoxShadow(
      //                 spreadRadius: 1,
      //                 color: Colors.black12,
      //                 blurRadius: 15,
      //
      //               ),
      //             ],
      //           ),
      //            child: Padding(
      //              padding: EdgeInsets.symmetric(horizontal: 9.w),
      //              child: Row(
      //                mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                children:   [
      //                  IconButton(
      //                    onPressed: (){
      //                      print('Home is pressed');
      //                      setState(() {
      //                        home = true;
      //                        search = false;
      //                        compagin = false;
      //                        profile = false;
      //
      //                      });
      //                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(),),);
      //                    },
      //
      //                    icon:Icon(Icons.home_outlined, size: 34, color: home ? kmaincolor : knormalText,)),
      //
      //                  IconButton(
      //                      onPressed: (){
      //                        print('search is pressed');
      //                        setState(() {
      //                          home = false;
      //                          search = true;
      //                          compagin = false;
      //                          profile = false;
      //                        });
      //                      },
      //
      //                      icon:Icon(Icons.search, size: 34, color: search ? kmaincolor : knormalText,)),
      //                  IconButton(onPressed: (){
      //                    print('campain is pressed');
      //                    setState(() {
      //                      home = false;
      //                      search = false;
      //                      compagin = true;
      //                      profile = false;
      //                    });
      //                  }, icon: Icon(Icons.electric_bolt, size: 34, color: compagin ? kmaincolor : knormalText,),),
      //
      //
      //
      //
      //                  IconButton(
      //                      onPressed: (){
      //                        print('profile is pressed');
      //                        setState(() {
      //                          home = false;
      //                          search = false;
      //                          compagin = false;
      //                          profile = true;
      //                        });
      //                      },
      //
      //                      icon:Icon(Icons.person_2_outlined, size: 34, color: profile ? kmaincolor : knormalText,)),
      //
      //                ],
      //              ),
      //            ),
      //       ),
      //        ),
      //       Positioned(
      //         top: 680.h,
      //         // bottom: 50.h,
      //         child: Container(
      //           decoration:const BoxDecoration(
      //             boxShadow:  [
      //               BoxShadow(
      //                blurStyle: BlurStyle.outer,
      //                 color: Colors.black12,
      //                 blurRadius: 5,
      //                 spreadRadius: -35,
      //               //  offset: Offset.
      //               ),
      //             ],
      //           ),
      //           child: Image.asset('images/navigation_bar_blood_drop.png',width: 70.w, fit: BoxFit.cover,),
      //
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
