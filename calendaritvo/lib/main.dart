import 'package:calendaritvo/src/pages/home_page.dart';
import 'package:calendaritvo/src/pages/info_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horario Escolar',
      home: Scaffold(                
      ),      
      initialRoute: "homepage",
      routes: {
        "homepage": (BuildContext context)=>HomePage(),
        "info": (BuildContext context)=>InfoPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.pink,
        
      )
    );
  }
}