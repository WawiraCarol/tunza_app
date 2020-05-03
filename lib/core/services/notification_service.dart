import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationService{
//  final MethodChannel platform =
//  MethodChannel('crossingthestreams.io/resourceResolver');
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  // Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
  final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
  BehaviorSubject<ReceivedNotification>();

  final StreamController<String> selectNotificationSubject =
  StreamController<String>.broadcast();

  NotificationAppLaunchDetails notificationAppLaunchDetails;
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;
  NotificationService(){
    this.initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
          this.didReceiveLocalNotificationSubject.add(ReceivedNotification(
              id: id, title: title, body: body, payload: payload));
        });
    this.initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    this.initializationSettings = InitializationSettings(
        this.initializationSettingsAndroid, initializationSettingsIOS);
  }
  Future<void> showNotification(id,title,body,payload) async {
//    String alarmUri = await platform.invokeMethod('getAlarmUri');
//    final x = UriAndroidNotificationSound(alarmUri);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Call from xxx', body, platformChannelSpecifics,
        payload: payload);
  }

}
class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}
