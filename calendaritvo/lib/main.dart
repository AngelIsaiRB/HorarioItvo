import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:calendaritvo/src/pages/add_materia.dart';
import 'package:calendaritvo/src/pages/calendario_page.dart';
import 'package:calendaritvo/src/pages/contact.dart';
import 'package:calendaritvo/src/pages/home_page.dart';
import 'package:calendaritvo/src/pages/info_page.dart';
import 'package:calendaritvo/src/pages/settingsPages/dangerZone.dart';
import 'package:calendaritvo/src/pages/settingsPages/developer.dart';
import 'package:calendaritvo/src/pages/settingsPages/extraSetings.dart';
import 'package:calendaritvo/src/pages/settingsPages/imagefond.dart';
import 'package:calendaritvo/src/pages/settingsPages/switchColor.dart';
import 'package:calendaritvo/src/pages/settingsPages/themaSelector.dart';
import 'package:calendaritvo/src/pages/settings_page.dart';
import 'package:calendaritvo/src/pages/welcome_page.dart';
import 'package:calendaritvo/src/provider/firebase_messagin.dart';
import 'package:calendaritvo/src/provider/notificatios_local_provide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendaritvo/src/utils/thema_utils.dart' as utils;

 
void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  final prefs =  PreferenciasUsuario();
  await prefs.initprefs();
  runApp(MyApp());

}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();



}

class _MyAppState extends State<MyApp> {

 

  @override
  void initState() {
    final ProviderMessages messagesFirebase = new ProviderMessages();
    messagesFirebase.initNotifications();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    final pref=PreferenciasUsuario();    
    final them=utils.thema(pref.colorApp);    

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horario Escolar',
      home: Scaffold(                
      ),      
      initialRoute: pref.welcomePage==true?"welcomePage":"homepage",
      routes: {
        "homepage"   : (BuildContext context)=>HomePage(),
        "info"       : (BuildContext context)=>InfoPage(),
        "addMateria" : (BuildContext context)=>AddMateri(),
        "settings"   : (BuildContext context)=>SettingsPage(),
        "calendario" : (BuildContext context)=>CalendarioPage(),
        "restart"    : (BuildContext context)=>MyApp(),
        "welcomePage": (BuildContext context)=>WelcomePage(),
        "contact": (BuildContext context)=>ContactPage(),        
        "imagefond" :(BuildContext context)=>ImageFonda(),
        "themaSelector" :(BuildContext context)=>TemaSelector(),
        "switchcolor" :(BuildContext context)=>SwitchColor(),
        "extraSettings" :(BuildContext context)=>ExtraSettings(),
        "dangerZona" :(BuildContext context)=>DangerZone(),
        "developer" :(BuildContext context)=>Developer(),
      },
      
       theme: them,
    );
  }
   
}

