import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/home_widgets/emergencies/ambulance.dart';
import 'package:flutter_demo/widgets/home_widgets/emergencies/army.dart';
import 'package:flutter_demo/widgets/home_widgets/emergencies/firebrigade.dart';
import 'package:flutter_demo/widgets/home_widgets/emergencies/police.dart';


class Emergency extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height:180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceEmergency(),
          AmbulanceEmergency(),
          FirebrigadeEmergency(),
          ArmyEmergency(),
        ],
      )
    );
  }
}