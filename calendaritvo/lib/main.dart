import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:calendaritvo/src/pages/add_materia.dart';
import 'package:calendaritvo/src/pages/calendario_page.dart';
import 'package:calendaritvo/src/pages/home_page.dart';
import 'package:calendaritvo/src/pages/info_page.dart';
import 'package:calendaritvo/src/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:calendaritvo/src/utils/thema_utils.dart' as utils;
 
void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  final prefs =  PreferenciasUsuario();
  await prefs.initprefs();
  runApp(MyApp());

}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pref=PreferenciasUsuario();    
    final them=utils.thema(pref.colorApp);    
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horario Escolar',
      home: Scaffold(                
      ),      
      initialRoute: "homepage",
      routes: {
        "homepage"   : (BuildContext context)=>HomePage(),
        "info"       : (BuildContext context)=>InfoPage(),
        "addMateria" : (BuildContext context)=>AddMateri(),
        "settings"   : (BuildContext context)=>SettingsPage(),
        "calendario" : (BuildContext context)=>CalendarioPage(),
        "restart"    : (BuildContext context)=>MyApp(),
      },
      
       theme: them,
    );
  }
}