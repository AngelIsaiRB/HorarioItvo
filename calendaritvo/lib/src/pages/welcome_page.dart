import 'dart:math';
import 'dart:ui';

import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  
  final pref = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: [
        _fondoapp(),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY:5.0 ),
          child: Column(         
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.all(30.0),
                child: Text("¿Eres parte de la comunidad ITVO?", style: TextStyle(fontSize: 35.0, color: Colors.white),)),
              Text("Instituto tecnológico del Valle de Oaxaca",style: TextStyle(fontSize: 20.0, color: Colors.white)),
              SizedBox(height: 100.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    color: Colors.blue,
                    onPressed: (){
                       
                      Navigator.pushReplacementNamed(context,"homepage" );
                    },
                    child: Text("SI", style: TextStyle(fontSize:40.0, color: Colors.white ),),
                  ),
                  FlatButton(
                    color: Colors.red,
                    onPressed: (){
                      pref.menu=true;
                      
                       Navigator.pushReplacementNamed(context,"homepage" );
                    },
                    child: Text("NO", style: TextStyle(fontSize:40.0, color: Colors.white ),),
                  ),
                ],
              ),
              SizedBox(height: 100.0,),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text('Si tu respuesta es "NO", se desactivarán ventanas'
                ' con información y noticias sobre el ITVO puedes '
                'activarlas en cualquier momento en "ajustes"', style: TextStyle( color: Colors.white),),
              )
            ],
          ),
        )        
      ],
    ),
    );
  }
    Widget _fondoapp() {
    final gradiente =Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0,0.0) ,
          end:   FractionalOffset(0.0,1.0), 
         List: [
           Color.fromRGBO(15, 12, 41,1.0),
           
           Color.fromRGBO(31, 28, 24,1.0),
         ]
        ),
      ),
    );

  final cajaRosa=Transform.rotate(
    angle: -pi/5.0,    
  child:Container(
    height: 360.0,
    width: 360.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90.0),
      gradient: LinearGradient(          
         List: [
           Color.fromRGBO(18, 194, 233,0.2),
           Color.fromRGBO(196, 113, 237,0.2),
          
           
         ]
        ),
    ),
    ) ,
  );

  

    return Stack(
      children: [
        gradiente,
        Positioned(
          top: 0,
          left: 65,
          child:  cajaRosa,
        ),
        Positioned(
          top: 420,
          left: -25,
          child:  cajaRosa,
        )
      ],
    );
  }
}