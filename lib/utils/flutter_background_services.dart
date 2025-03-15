import 'dart:async';
import 'dart:ui';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_demo/db/db_services.dart';
import 'package:flutter_demo/model/contactsm.dart';
import 'package:telephony/telephony.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shake/shake.dart';

final Telephony telephony = Telephony.instance;

/// Sends an emergency SMS with location
Future<void> sendMessage(String messageBody) async {
  List<TContact> contactList = await DatabaseHelper().getContactList();
  if (contactList.isEmpty) {
    Fluttertoast.showToast(msg: "No number exists. Please add a number.");
    return;
  }

  for (var contact in contactList) {
    telephony
        .sendSms(to: contact.number, message: messageBody)
        .then((_) {
          Fluttertoast.showToast(msg: "Message sent to ${contact.number}");
        })
        .catchError((error) {
          Fluttertoast.showToast(msg: "Failed to send message: $error");
        });
  }
}

/// Initializes the background service
Future<void> initializeService() async {
  if (kIsWeb) {
    print("⚠️ Background services are not supported on Web.");
    return;
  }

  if (!(Platform.isAndroid || Platform.isIOS)) {
    print("⚠️ Background services only supported on Android & iOS.");
    return;
  }

  final service = FlutterBackgroundService();

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    "script_academy",
    "Foreground Service",
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
      autoStartOnBoot: true,
      notificationChannelId: "script_academy",
      initialNotificationTitle: "Foreground Service",
      initialNotificationContent: "Initializing...",
      foregroundServiceNotificationId: 888,
    ),
  );

  service.startService();
}

/// Background Service Entry Point
@pragma('vm-entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });

    service.on('stopService').listen((event) {
      service.stopSelf();
    });
  }

  Timer.periodic(Duration(seconds: 2), (timer) async {
    if (service is AndroidServiceInstance &&
        await service.isForegroundService()) {
      Position? currentPosition;
      try {
        currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true,
        );
        print(
          "📍 Background Location: ${currentPosition.latitude}, ${currentPosition.longitude}",
        );
      } catch (e) {
        Fluttertoast.showToast(msg: "Location Error: ${e.toString()}");
        return;
      }

      // Shake Detection
      ShakeDetector.autoStart(
        shakeThresholdGravity: 7,
        shakeSlopTimeMS: 500,
        shakeCountResetTime: 3000,
        minimumShakeCount: 1,
        onPhoneShake: () async {
          if (await Vibration.hasVibrator() ?? false) {
            if (await Vibration.hasCustomVibrationsSupport() ?? false) {
              Vibration.vibrate(duration: 1000);
            } else {
              Vibration.vibrate();
              await Future.delayed(Duration(milliseconds: 500));
              Vibration.vibrate();
            }
          }
          if (currentPosition != null) {
            String messageBody =
                "https://www.google.com/maps/search/?api=1&query=${currentPosition.latitude}%2C${currentPosition.longitude}"; // sim should be disabled
            sendMessage(messageBody);
          }
        },
      );

      // Show Persistent Notification
      flutterLocalNotificationsPlugin.show(
        888,
        "Women Safety App",
        "Shake feature enabled",
        NotificationDetails(
          android: AndroidNotificationDetails(
            "script_academy",
            "Foreground Service",
            importance: Importance.high,
            icon: 'ic_bg_service_small',
            ongoing: true,
          ),
        ),
      );
    }
  });
}
