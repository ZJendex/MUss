// Retrieved from: https://www.youtube.com/watch?v=PJ_AH61dTIc
// Within https://pub.dev/packages/flutter_local_notifications

import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

class NotificationPlugin {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late InitializationSettings initializationSettings;
  final BehaviorSubject<ReceivedNotification>
      didReceivedLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();

  NotificationPlugin() {
    init();
  }

  void init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermission();
    } else if (Platform.isAndroid) {
      _requestAndroidPermission();
    }
    initializedPlatformSpecifics();
  }

  void initializedPlatformSpecifics() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings("@mipmap/muss_trans");
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceivedNotification receivedNotification = ReceivedNotification(
            id: id, title: title!, body: body!, payload: payload!);
        didReceivedLocalNotificationSubject.add(receivedNotification);
      },
    );

    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  void _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: false, badge: true, sound: true);
  }

  void _requestAndroidPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    didReceivedLocalNotificationSubject.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: ((details) {
      onNotificationClick(details.payload);
    }));
  }

  Future<void> showNotification(
      String title, String body, String payload) async {
    var androidChannelSpecifics = const AndroidNotificationDetails(
        'CHANNEL_ID', 'CHANNEL_NAME',
        channelDescription: 'CHANNEL_DESCRIPTION',
        importance: Importance.max,
        priority: Priority.max);
    var iosChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<void> showScheduledNotification(
      String title, String body, String payload, Duration offset) async {
    DateTime scheduledNotificationDateTime = DateTime.now().add(offset);
    var androidChannelSpecifics = const AndroidNotificationDetails(
        'CHANNEL_ID_2', 'CHANNEL_NAME_2',
        channelDescription: 'CHANNEL_DESCRIPTION_2',
        importance: Importance.max,
        priority: Priority.high);
    // notification priority in Android
    // https://developer.android.com/develop/ui/views/notifications#Heads-up
    var iosChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        1, title, body, scheduledNotificationDateTime, platformChannelSpecifics,
        payload: payload);
  }

  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}
