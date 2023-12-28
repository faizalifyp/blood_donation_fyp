import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> setupFirebase() async {
    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
      // Save the token on your server (Firestore, for example)
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground messages
      // Display a local notification or update the UI
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle background messages when the app is opened
      // Navigate to a specific screen or handle the notification data
    });
  }

  Future<void> sendBloodRequestNotifications(String bloodType) async {
    // Query the users collection to find users with matching blood types
    // and their FCM tokens
    // For simplicity, let's assume you have a 'users' collection with 'fcmToken' field

    QuerySnapshot<Map<String, dynamic>> usersSnapshot =
    await FirebaseFirestore.instance.collection('users').where('bloodGroup', isEqualTo: bloodType).get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> user in usersSnapshot.docs) {
      String fcmToken = user['fcmToken'];
      if (fcmToken != null && fcmToken.isNotEmpty) {
        // Send a notification to each user
        log("token: "+ fcmToken);
        await _sendNotification(fcmToken, 'Blood Request', 'New blood request matching your blood type!');
      }
    }
  }

  Future<void> _sendNotification(String fcmToken, String title, String body) async {
    await _firebaseMessaging.sendMessage(
      to: fcmToken,
      data: {
        'title': title,
        'body': body,
      },
    );
  }
}
