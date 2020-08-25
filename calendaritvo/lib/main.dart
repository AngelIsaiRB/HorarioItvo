import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:calendaritvo/src/pages/add_materia.dart';
import 'package:calendaritvo/src/pages/home_page.dart';
import 'package:calendaritvo/src/pages/info_page.dart';
import 'package:calendaritvo/src/pages/settings_page.dart';
import 'package:flutter/material.dart';
 
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
    Color primary;
    Color secundary;
    if(pref.secundaryColor){
       
        primary=Colors.teal;
        secundary=Colors.teal[50];
    }
    else{
        primary=Colors.pink;
        secundary=Colors.pink[50];
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horario Escolar',
      home: Scaffold(                
      ),      
      initialRoute: "homepage",
      routes: {
        "homepage"  : (BuildContext context)=>HomePage(),
        "info"      : (BuildContext context)=>InfoPage(),
        "addMateria": (BuildContext context)=>AddMateri(),
        "settings"  : (BuildContext context)=>SettingsPage(),
      },
      theme: ThemeData(
        primaryColor: primary,
        primaryColorLight: secundary,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white,fontSize: 18.0),
          bodyText2: TextStyle(color: Colors.white),
         subtitle1: TextStyle(color: Colors.black),
         subtitle2: TextStyle(color: Colors.white, backgroundColor: Colors.black26, fontSize: 17.0),
          ),
        backgroundColor: Color.fromRGBO(48, 48, 48, 1.0),  

        
      )
    );
  }
}