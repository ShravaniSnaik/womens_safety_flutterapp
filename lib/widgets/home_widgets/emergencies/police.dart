import 'package:flutter/material.dart';

class PoliceEmergency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Color(0xFFFD8080), Color(0xFFFB8580), Color(0xFFFBD079)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white.withOpacity(0.5),
                child: Image.asset('assets/alert.png'),
              ),

              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Active Emergency',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                    ),
                    Text(
                      'call 0-1-5 for emergencies',
                      style: TextStyle(
                        color: Colors.white,

                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                    ),
                    Container(
                      height: 30,
                      width:80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      
                      child: Text('0-1-5',
                    style: TextStyle(
                        color: Colors.white,

                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                    )),
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
