import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screen/Bottom_Navigation_Bar.dart';
import 'screen/Introductory Pages/intropage1.dart';
import 'screen/botoom_navigation.dart';
import 'screen/splash_screen.dart';
import 'screen/botoom_navigation.dart';




Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 808),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context , child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'First Step',
        // You can use the library anywhere in the app even in theme
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
        ),
        home: const SplashScreen(),
      );
    }
    );
  }
}

