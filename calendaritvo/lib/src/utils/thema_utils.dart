import 'package:flutter/material.dart';

ThemeData thema(int value){
  final List<Color> colores=[];  

  if (value ==888 ){
    return ThemeData(
         primaryColor: Colors.pink,
          primaryColorLight:Color.fromRGBO(38, 38, 38,1),         
          brightness: Brightness.dark,
          primarySwatch: Colors.orange, 
          backgroundColor: Color.fromRGBO(48, 48, 48, 1.0),           
          textTheme: TextTheme(
          headline3: TextStyle(color:Colors.white,fontSize:35.0, fontStyle: FontStyle.italic  ),
          headline2: TextStyle(color: Colors.white, fontSize: 40.0),
          bodyText1: TextStyle(color: Colors.white,fontSize: 20.0),
          bodyText2: TextStyle(color: Colors.black,fontSize: 17.0),//texto tarjeta
         subtitle1: TextStyle(color: Colors.white),// opciones en ajjstes
         subtitle2: TextStyle(color: Colors.white, backgroundColor: Colors.black26, fontSize: 17.0),//texto hora horari
          ),
        );
  }  
  if(value==0){
    colores.add(Colors.pink);
    colores.add(Colors.pink[50]);
  }
  else if(value==1){
    colores.add(Colors.teal);
    colores.add(Colors.teal[50]);
  }
  else if(value==2){
    colores.add(Colors.pink[200]);
    colores.add(Color.fromRGBO(68, 78, 105, 1));
  }
    return ThemeData(
        primaryColor: colores[0],
        primaryColorLight: colores[1],
        
        primaryIconTheme: IconThemeData(color: Colors.black), //menu noticias
        textTheme: TextTheme(
          headline3: TextStyle(color:Colors.black,fontSize:35.0, fontStyle: FontStyle.italic  ),
          headline2: TextStyle(color: Colors.black, fontSize: 40.0),
          bodyText1: TextStyle(color: Colors.black,fontSize: 20.0),
          bodyText2: TextStyle(color: Colors.black,fontSize: 17.0),
         subtitle1: TextStyle(color: Colors.black),
         subtitle2: TextStyle(color: Colors.white, backgroundColor: Colors.black26, fontSize: 17.0),
          ),        
        backgroundColor: Color.fromRGBO(48, 48, 48, 1.0),  

        
      );

  
 


}