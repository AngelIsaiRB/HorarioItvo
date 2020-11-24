import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notifications {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    init()async {
      tz.initializeTimeZones();   
      tz.setLocalLocation(tz.getLocation("America/Mexico_City"));
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
  Future<void> scheduleWeeklyMondayTenAMNotification({int id ,String materia, String texto,int dia,int hora, int minuto}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        materia,
        texto,
        _nextInstanceOfMondayTenAM(dia,hora,minuto),
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
  tz.TZDateTime _nextInstanceOfMondayTenAM(int dia, int hora, int minuto) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTenAM(hora, minuto);
    while (scheduledDate.weekday != dia) {     
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    print("notification: ${scheduledDate.weekday}-${scheduledDate.day}-${scheduledDate.hour}-${scheduledDate.minute}");             
    return scheduledDate;
  }
  tz.TZDateTime _nextInstanceOfTenAM(int hora, int minuto) {
    
    
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);   
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hora, minuto);        
        print("now: ${now.weekday}-${now.day}-${now.hour}-${now.minute}");             
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }     
    return scheduledDate;
  }
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}