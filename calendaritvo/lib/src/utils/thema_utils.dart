import 'package:flutter/material.dart';

ThemeData thema(int value){
  final List<Color> colores=[];  

  if (value ==888 ){
    return ThemeData(
         primaryColor: Colors.pink,
        accentColor: Colors.pink,
          primaryColorLight:Color.fromRGBO(38, 38, 38,1),         
          brightness: Brightness.dark,
          primarySwatch: Colors.orange, 
          primaryColorDark: Colors.white,
          backgroundColor: Color.fromRGBO(48, 48, 48, 1.0),  
          shadowColor: Colors.black,       
          textTheme: TextTheme(
          headline3: TextStyle(color:Colors.white,fontSize:35.0, fontStyle: FontStyle.italic  ),
          headline2: TextStyle(color: Colors.white, fontSize: 30.0),
          bodyText1: TextStyle(color: Colors.white,fontSize: 20.0),
          bodyText2: TextStyle(color: Colors.white,fontSize: 17.0),//texto tarjeta
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
  else if(value==3){
    colores.add(Colors.purple);
    colores.add(Color.fromRGBO(255, 218, 125, 1));
  }
   else if(value==4){
   colores.add(Colors.red);
    colores.add(Colors.yellow[50]);
  }
  else if (value==5){        
    
    colores.add(Color.fromRGBO( 234, 95, 64, 1));
     colores.add(Color.fromRGBO( 31, 78, 90, 1));
  }
  else if (value==6){        
    colores.add(Color.fromRGBO( 20, 102, 75, 1));  
     colores.add(Color.fromRGBO( 230, 242, 238, 1));
       
  }
  else if (value==7){        
    colores.add(Color.fromRGBO( 118, 96, 146, 1));  
     colores.add(Color.fromRGBO( 231, 211, 238, 1));
       
  }else if (value==8){        
     colores.add(Colors.blue);  
     colores.add(Colors.blue[50]);          
  }
    return ThemeData(
        primaryColor: colores[0],
        primaryColorLight: colores[1],
        cardColor: Colors.grey[200],        
        primaryIconTheme: IconThemeData(color: Colors.black), //menu noticias
        textTheme: TextTheme(
          headline3: TextStyle(color : Colors.black,fontSize:35.0, fontStyle: FontStyle.italic  ),
          headline2: TextStyle(color : Colors.black, fontSize: 30.0),
          bodyText1: TextStyle(color : Colors.black,fontSize: 20.0),
          bodyText2: TextStyle(color : Colors.black,fontSize: 17.0),
         subtitle1: TextStyle (color : Colors.black),
         subtitle2: TextStyle (color : Colors.white, backgroundColor: Colors.black26, fontSize: 17.0),
          ),        
        backgroundColor: Color.fromRGBO(48, 48, 48, 1.0),  
        

        
      );

  
 


}