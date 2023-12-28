import 'package:blood_donation_fyp/constants/constant.dart';
import 'package:blood_donation_fyp/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chatscreen.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatUser user;

  ChatDetailScreen({required this.user});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: kmaincolor,
        title: Text(widget.user.username),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(getChatID(getCurrentUserId(), 'mOkLBZZltQfOXbKwsKCMAMWhyn22'))
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var messages = snapshot.data!.docs.reversed.toList();

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index].data() as Map<String, dynamic>;
                    bool isSender = message['sender'] == getCurrentUserId();

                    return Align(
                      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: isSender ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          message['text'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                );
              },
            ),

          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      String user1ID = getCurrentUserId();
                      String user2ID = widget.user.uid;

                      // Handle sending the message to Firebase
                      String messageText = _messageController.text;
                      if (messageText.isNotEmpty) {
                        FirebaseFirestore.instance
                            .collection('chats')
                            .doc(getChatID(user1ID, user2ID))
                            .collection('messages')
                            .add({
                          'text': messageText,
                          'sender': user1ID,
                          // Update with the sender's name or ID
                          'timestamp': FieldValue.serverTimestamp(),
                        });

                        // Clear the text field after sending the message
                        _messageController.clear();
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String senderID;
  final String text;
  final DateTime timestamp;

  Message({
    required this.senderID,
    required this.text,
    required this.timestamp,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderID: map['senderID'],
      text: map['text'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}

Future<void> sendMessage(String chatID, String senderID, String text) {
  return FirebaseFirestore.instance
      .collection('chats')
      .doc(chatID)
      .collection('messages')
      .add({
    'senderID': senderID,
    'text': text,
    'timestamp': FieldValue.serverTimestamp(),
  });
}

Stream<List<Message>> getChatMessages(String chatID) {
  return FirebaseFirestore.instance
      .collection('chats')
      .doc(chatID)
      .collection('messages')
      .orderBy('timestamp')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      return Message(
        senderID: doc['senderID'],
        text: doc['text'],
        timestamp: doc['timestamp'],
      );
    }).toList();
  });
}

String getChatID(String userID1, String userID2) {
  List<String> sortedUserIDs = [userID1, userID2]..sort();
  print(sortedUserIDs.join('_'));
  print(sortedUserIDs.join('_'));

  return sortedUserIDs.join('_');
}
