import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notifications {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    init()async {
      tz.initializeTimeZones();   
      tz.setLocalLocation(tz.getLocation("America/North_Dakota/Beulah"));
      const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('launcher_icon');
      final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    }
    Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'holamundo', 'este es un mensaje', platformChannelSpecifics,
        payload: 'item x');
  }
  Future<void> scheduleWeeklyMondayTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'weekly scheduled notification title',
        'weekly scheduled notification body',
        _nextInstanceOfMondayTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'weekly notification channel id',
              'weekly notification channel name',
              'weekly notificationdescription',
              importance: Importance.max,
              priority: Priority.max ),
        ),
        androidAllowWhileIdle: true,
        
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
        print("alarma ajustada------*********");
  }
  tz.TZDateTime _nextInstanceOfMondayTenAM() {
    tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
    while (scheduledDate.weekday != DateTime.friday) {
      print("_:::::::::::::::::${scheduledDate.weekday}");
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    print(scheduledDate.weekday);
    print(scheduledDate.day);
    print(scheduledDate.hour);
    print(scheduledDate.minute);
    return scheduledDate;
  }
  tz.TZDateTime _nextInstanceOfTenAM() {
    
    
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);   
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 18,30);
        print("///////////////////////////////////////////");
        print(now.weekday);
    print(now.day);
    print(now.hour);
    print(now.minute);
        print("///////////////////////////////////////////");
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    } 
     print("_:==================${scheduledDate.weekday}");   
    return scheduledDate;
  }
}