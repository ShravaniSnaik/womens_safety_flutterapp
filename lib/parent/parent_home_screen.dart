import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/chat_module/chat_screen.dart';
import 'package:flutter_demo/child/child_login_screen.dart';
import 'package:flutter_demo/utils/constants.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(

          drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Container(

              )
              ),
                ListTile(
                  title: TextButton(
          onPressed: ()async{
            try {
              FirebaseAuth.instance.signOut();
              goTo(context, LoginScreen());
            } on FirebaseAuthException catch (e) {
              dialogueBox(context, e.toString());
            }
          },
       child: Text(
        'Sing Out'
        )),
                )
              ]
              ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 246, 3, 84),
        title: Text('Select Guardian'),
      ),
      body: StreamBuilder(
      stream: FirebaseFirestore.instance
      .collection('users')
      .where('type',isEqualTo: 'child')
      .where('guardianEmail',isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .snapshots(),
       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return Center(child: progressIndicator(context));
        }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index){
                final d=snapshot.data!.docs[index];
                return Padding(padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Color.fromARGB(255,250,163,192),
                  child: ListTile(
                    onTap: (){
                     goTo(context,
                     ChatScreen(currentUserId: FirebaseAuth.instance.currentUser!.uid,
                      friendId: d.id,
                      friendName:d['name']));
                    } ,
                    title: Padding(
                      padding:const EdgeInsets.all(8.0),
                     child: Text(d['name']),
                     )
                  ),
                ),);
              },
            );
       }
       )
    );
  }
}