
import 'package:firebase_messaging/firebase_messaging.dart';

class ProviderMessages {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

 static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
   // print("**************************************************************************************");
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    //print("**************************************************************************************");
  }

  // Or do other work.
}    

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();
    final id= await _firebaseMessaging.getToken();
    //print("----------------- $id");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
       // print("----------");
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
       //print("----------------");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
       // print("--------------");
      },
    );  
    
  }

}