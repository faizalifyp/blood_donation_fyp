import 'package:blood_donation_fyp/Models/User.dart';
import 'package:blood_donation_fyp/screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';
import '../widgets/textwidget.dart';
import 'ChatDetailScreen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    print("building");
    return Scaffold(
      backgroundColor: knormalText,
      appBar: AppBar(
        backgroundColor: kmaincolor,
        title: Text('Chat Screen'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('user1ID', isEqualTo: getCurrentUserId())
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<String> chatIDs = snapshot.data!.docs.map((doc) => doc.id).toList();

          return ListView.builder(
            itemCount: chatIDs.length,
            itemBuilder: (context, index) {
              print("first " + chatIDs[index].split("_")[1]);
              return FutureBuilder(
                future: fetchUser(chatIDs[index].split("_")[1]),
                builder: (context, AsyncSnapshot<UserModel> userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (userSnapshot.hasError) {
                    return Center(
                      child: Text('Error: ${userSnapshot.error}'),
                    );
                  }

                  ChatUser chatUser = ChatUser(
                    uid: userSnapshot.data!.uid,
                    username: userSnapshot.data!.name,
                    avatar: userSnapshot.data!.image ?? '', // Handle null image
                    lastText: userSnapshot.data!.name,
                  );

                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatDetailScreen(user: chatUser),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kcallbuttoncolor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 32.0,
                                backgroundImage: NetworkImage(chatUser.avatar),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                chatUser.username,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

// Example User class
class ChatUser {
  final String uid;
  final String username;
  final String avatar;
  final String lastText;

  ChatUser({required this.uid, required this.username, required this.avatar, required this.lastText});
}

Future<List<String>> fetchUserChats(String userID) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
      .collection('chats')
      .where('user1ID', isEqualTo: userID)
      .get();

  List<String> chatIDs = snapshot.docs.map((doc) => doc.id).toList();
  return chatIDs;
}

