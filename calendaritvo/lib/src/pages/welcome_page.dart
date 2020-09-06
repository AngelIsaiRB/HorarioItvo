import 'dart:math';

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: [
        _fondoapp(),
        Center(
          child: Text("data"),
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
          begin: FractionalOffset(0.0,0.6) ,
          end:   FractionalOffset(0.0,1.0), 
         colors: [
           Color.fromRGBO(52, 54, 101,1.0),
           Color.fromRGBO(35, 37, 57,1.0),
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
         colors: [
           Color.fromRGBO(236, 98, 188,0.2),
           Color.fromRGBO(241, 142, 172,0.2),
         ]
        ),
    ),
    ) ,
  );

  

    return Stack(
      children: [
        gradiente,
        Positioned(
          top: 10,
          left: 75,
          child:  cajaRosa,
        ),
        Positioned(
          top: 400,
          left: -75,
          child:  cajaRosa,
        )
      ],
    );
  }
}