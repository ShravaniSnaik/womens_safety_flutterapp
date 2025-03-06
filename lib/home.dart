import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/home_widgets/CustomCarouel.dart';
import 'package:flutter_demo/widgets/home_widgets/custom_appBar.dart';
import 'package:flutter_demo/widgets/home_widgets/emergency.dart';
import 'package:flutter_demo/widgets/home_widgets/livesafe.dart';
import 'package:flutter_demo/widgets/home_widgets/safehome/SafeHome.dart';



class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //const HomePage({super.key});
  int qIndex = 0;

  void getRandomQuote() {
    Random random = Random();

    setState(() {
      qIndex = random.nextInt(12);
    });
  }

  @override
  void initState() {
    getRandomQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomAppbar(getRandomQuote, qIndex),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomCarousel(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Emergency",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Emergency(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Explore LiveSafe",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    LiveSafe(),
                    Padding(
                padding: const EdgeInsets.all(8.0),
                
              ),
                    SafeHome(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
