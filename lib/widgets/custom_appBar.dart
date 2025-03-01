import 'package:flutter/material.dart';

import '../utils/quotes.dart';

class CustomAppbar extends StatelessWidget {
  //const CustomAppbar({super.key});

final Function ? onTap;
final int ? quoteIndex;
const CustomAppbar(this.onTap,this.quoteIndex,{super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
    child:Container(
      child:Text(
      womenEmpowermentQuotes[quoteIndex??0],
      style:const TextStyle(
        fontSize: 22,
        backgroundColor: Colors.blue,
      ),
      ),
    ),
    );
  }
}