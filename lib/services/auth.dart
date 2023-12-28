import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_donation_fyp/Models/User.dart';

String resposne = "";

Future<bool> signUpWithEmailAndPassword(UserModel user) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
    // User successfully signed up
    User? firebaseUser = userCredential.user;
    log('User signed up with email: ${firebaseUser?.email}');

    // Add user data to Firestore
    await addUserToFirestore(firebaseUser!.uid,user);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      resposne = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      resposne = 'The account already exists for that email.';

    }
    return false;

  } catch (e) {
    log(e.toString());
    return false;

  }

  log('user added');
  return true;

}


// Function to add user data to Firestore
Future<void> addUserToFirestore(String uid, UserModel user) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  log("collection user is: "+ uid);

  await users.add({
    'uid': uid,
    'name': user.name,
    'email': user.email,
    'phone': user.phone,
    'bloodGroup': user.bloodGroup,
    'location': user.location,
  });
}


Future<bool> doesUserExist(String email) async {
  try {
    // Query Firestore or your user database to check if the user exists
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    return querySnapshot.docs.isNotEmpty; // User exists if there are matching documents
  } catch (e) {
    // Handle any exceptions or errors
    print('Error checking user existence: $e');
    return false;
  }
}



Future<bool> signInWithEmailAndPassword(String email, String password) async {

  log("email: "+email);
  log("password: "+password);

  try {
    bool userExists = await doesUserExist(email);

    if (!userExists) {
      log('No user found.');
      resposne = "No user found.";
      return false;
    }


    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // User successfully signed in
    User? firebaseUser = userCredential.user;
    log('User signed in with email: ${firebaseUser?.email}');

    // Get user data from Firestore
    if (firebaseUser != null) {
      UserModel user = UserModel(uid:firebaseUser.uid , email: firebaseUser.email!, password: '', name: '', phone: '', bloodGroup: '', location: '');
      userId = firebaseUser.uid;

      log("user id is :"+ userId);


      resposne = "Login Successful";

      return true;


    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      log('No user found.');
      resposne = "No user found.";
    } else if (e.code == 'wrong-password') {
      log('Wrong email or password.');
      resposne = "Wrong email or password.";
    }
    resposne = 'Wrong email or password.';

  }

  return false;
}

// Replace with your Firebase project configuration details

// Add this function to fetch all users from the Firestore collection
Future<List<UserModel>> fetchAllUsers(String currentUserId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot = await firestore.collection('users').get();
  List<UserModel> users = querySnapshot.docs.map((doc) {
    return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  }).toList();

  // Filtering out the current user based on their ID
  users.removeWhere((user) => user.uid == currentUserId);

  return users;
}


void signOut() async {
  await FirebaseAuth.instance.signOut();
  print('User signed out');
}