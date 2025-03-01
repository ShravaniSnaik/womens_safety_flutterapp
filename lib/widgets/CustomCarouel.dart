import 'package:flutter/material.dart';

class CustomCarouel extends StatelessWidget {
  const CustomCarouel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          autoplay: true,
        ),
        items: List.generate(
          imageSliders.length, 
          (index) => Card(
          elevation:5.0,
          shape:
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                ),

          )),
      ),
    );
  }
}