import 'dart:math';
import 'package:shake/shake.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/home_widgets/CustomCarouel.dart';
import 'package:flutter_demo/widgets/home_widgets/custom_appBar.dart';
import 'package:flutter_demo/widgets/home_widgets/emergency.dart';
import 'package:flutter_demo/widgets/home_widgets/livesafe.dart';
import 'package:flutter_demo/widgets/home_widgets/safehome/SafeHome.dart';
import '../../../db/db_services.dart';
import '../../../model/contactsm.dart';
import 'package:background_sms/background_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //const HomePage({super.key});
  int qIndex = 0;
  Position? _curentPosition;

  String? _curentAddress;
  LocationPermission? permission;

  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;

  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    await BackgroundSms.sendMessage(
      phoneNumber: phoneNumber,
      message: message,
      simSlot: simSlot,
    ).then((SmsStatus status) {
      if (status == "sent") {
        Fluttertoast.showToast(msg: "send");
      } else {
        Fluttertoast.showToast(msg: "failed");
      }
    });
  }

  _getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      Fluttertoast.showToast(msg: "Location permissions are deneid");
      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(
          msg: "Location permissions are permanently deneid",
        );
      }
    }
    await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true,
        )
        .then((Position position) {
          setState(() {
            _curentPosition = position;
            print(_curentPosition!.latitude);
            _getAddressFromLatLon();
          });
        })
        .catchError((e) {
          Fluttertoast.showToast(msg: e.toString());
        });
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _curentPosition!.latitude,
        _curentPosition!.longitude,
      );

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
            "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getRandomQuote() {
    Random random = Random();

    setState(() {
      qIndex = random.nextInt(12);
    });
  }

  getAndSendSms() async {
    List<TContact> contactList = await DatabaseHelper().getContactList();

    String messageBody =
        "https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}. $_curentAddress";
    if (await _isPermissionGranted()) {
      contactList.forEach((element) {
        _sendSms(
          "${element.number}",
          "i am in trouble $messageBody",
          simSlot: 1,
        );
      });
    } else {
      Fluttertoast.showToast(msg: "something wrong");
    }
  }

  @override
  void initState() {
    getRandomQuote();
    super.initState();
    _getPermission();
    _getCurrentLocation();
    //shake feature//

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
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
                    Padding(padding: const EdgeInsets.all(8.0)),
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
