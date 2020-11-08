import 'dart:io';
import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:flutter/material.dart';


 

  Widget imagenFondo(){   
  final pref= PreferenciasUsuario(); 
  return Container(
    width: double.infinity,
    height: double.infinity,
    
   child: Image(
      image:pref.ispathImage? FileImage(File(pref.imageFond)): AssetImage(pref.imageFond),
      fit: BoxFit.cover,
   ),
    
  );
}
