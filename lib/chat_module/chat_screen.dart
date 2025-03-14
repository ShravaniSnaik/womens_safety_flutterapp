import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/chat_module/message_text_field.dart';
import 'package:flutter_demo/chat_module/singleMessage.dart';
import 'package:flutter_demo/utils/constants.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final String friendId;
  final String friendName;

  const ChatScreen({
    super.key,
    required this.currentUserId,
    required this.friendId,
    required this.friendName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? type;
  String? myname;
  getStatus() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUserId)
        .get()
        .then((value) {
          setState(() {
            type = value.data()!['type'];
            myname = value.data()!['name'];
          });
        });
  }

  @override
  void initState() {
    getStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(widget.friendName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.currentUserId)
                      .collection('messages')
                      .doc(widget.friendId)
                      .collection('chats')
                      .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.length < 1) {
                    return Center(
                      child: Text(
                        type == 'parent'
                            ? "Talk with child"
                            : "Talk with parent",
                        style: TextStyle(fontSize: 30),
                      ),
                    );
                  }
                  return Container(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isMe =
                            snapshot.data!.docs[index]['senderId'] ==
                            widget.currentUserId;
                        final data = snapshot.data!.docs[index];
                        return SingleMessage(
                          message: data['message'],
                          date: data['date'],
                          isMe: isMe,
                          friendName: widget.friendName,
                          myName: myname,
                          type: data['type'],
                        );
                      },
                    ),
                  );
                }
                return progressIndicator(context);
              },
            ),
          ),

          MessageTextField(
            currentId: widget.currentUserId,
            friendId: widget.friendId,
          ),
        ],
      ),
    );
  }
}
