import 'package:flutter/material.dart';
import 'package:flutter_demo/child/bottom_screens/add_contacts.dart';
import 'package:flutter_demo/child/bottom_screens/chat_page.dart';
import './bottom_screens/contact_page.dart';
import 'package:flutter_demo/child/bottom_screens/home.dart';
import 'package:flutter_demo/child/bottom_screens/profile_page.dart';
import 'package:flutter_demo/child/bottom_screens/review_page.dart';

class BottomPage extends StatefulWidget {
  // const MyWidget({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomePage(),
    AddContactsPage(),
    ChatPage(),
    ProfilePage(),
    ReviewPage(),
  ];

  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
        items: [
          BottomNavigationBarItem(label: 'home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            label: 'contacts',
            icon: Icon(Icons.contacts),
          ),
          BottomNavigationBarItem(label: 'chats', icon: Icon(Icons.chat)),
          BottomNavigationBarItem(label: 'profile', icon: Icon(Icons.person)),
          BottomNavigationBarItem(label: 'Reviews', icon: Icon(Icons.reviews)),
        ],
      ),
    );
  }
}
