import 'dart:io';
import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


 

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

abrirLink(String link)async{
    if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Could not launch $link';
  }
}


 alertYesNo({BuildContext context, String mensaje, Function onYes, Function onNo}){
  return showDialog(
             context: context,
             barrierDismissible: true,
             builder: (context){
                 return  AlertDialog(
                   title: Text(mensaje),
                   actions: [
                     FlatButton(
                       child: Container(                         
                         padding: EdgeInsets.all(15),
                         child: Text("No")),
                       onPressed:onNo
                     ),
                     FlatButton(
                       child: Text("Si"),
                       onPressed:onYes,
                     ),
                   ],
                 );
             });
}
