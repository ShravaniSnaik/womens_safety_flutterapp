import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/CustomCarouel.dart';
import 'package:flutter_demo/widgets/custom_appBar.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //const HomePage({super.key});
int qIndex=0;

void getRandomQuote(){
  Random random=Random();
 
  setState(() {
     qIndex=random.nextInt(12);
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
        child:Padding(padding: const EdgeInsets.all(8.0),
        child: Column(
        children: [
          CustomAppbar(
           getRandomQuote,
          qIndex
          ),
          CustomCarousel(), 
        ],
      ),
      ),
        
      ),
    );
  }
}