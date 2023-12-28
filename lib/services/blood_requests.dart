import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/BloodRequest.dart';

// Add a new blood request to the Firestore
Future<void> addBloodRequest(BloodRequest request) async {
  CollectionReference requests = FirebaseFirestore.instance.collection('requests');
  await requests.doc(request.requestId).set(request.toJson());
}

// Fetch all blood requests from Firestore
Future<List<BloodRequest>> fetchAllBloodRequests() async {
  CollectionReference requests = FirebaseFirestore.instance.collection('requests');
  QuerySnapshot querySnapshot = await requests.get();
  List<BloodRequest> requestsList = [];
  querySnapshot.docs.forEach((doc) {
    requestsList.add(BloodRequest.fromJson(doc.data() as Map<String, dynamic>));
  });
  return requestsList;
}




// Function to reject a blood request
Future<void> rejectBloodRequest(String requestId) async {
  CollectionReference requests = FirebaseFirestore.instance.collection('requests');

  try {
    await requests.doc(requestId).update({
      'status': 'rejected',
    });
    print('Blood request with ID $requestId has been rejected.');
  } catch (e) {
    print('Error updating blood request: $e');
  }
}

// Function to accept a blood request
Future<void> acceptBloodRequest(String requestId, String acceptingUserUid) async {
  CollectionReference requests = FirebaseFirestore.instance.collection('requests');

  try {
    await requests.doc(requestId).update({
      'status': 'accepted',
      'acceptingUserUid': acceptingUserUid,
    });
    print('Blood request with ID $requestId has been accepted.');
  } catch (e) {
    print('Error updating blood request: $e');
  }
}
