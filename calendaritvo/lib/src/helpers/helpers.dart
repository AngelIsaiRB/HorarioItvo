import 'dart:io';
import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

mostrarAlertaAgregarCalificacion({BuildContext context,String title, String textAceptar, Function onOk}) {
  String text;
    showDialog(
      useSafeArea: true,
      context: context,
      barrierDismissible: true,      
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState){
            return AlertDialog(
          
          title: Text(title),
          content: Container(
            height: MediaQuery.of(context).size.width * 0.2,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                TextField(   
                  autofocus: true,
                  keyboardType: TextInputType.number,   
                  inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                    ],
                   decoration: InputDecoration(                     
                     hintText: "Calificacion",
                     labelText: "Calificacion",                                          
                     helperText: "Calificacion de tu parcial",
                     icon: Icon(
                       FontAwesomeIcons.clipboardCheck,
                       size: 40.0,
                     ),
                   ),
                   onChanged: (valor) {
                     text = valor;
                    
                   },
                ),
              ],
            ),
          ),      
          actions: [
            FlatButton(
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                textAceptar,
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: ()=> onOk(text),
            )
          ],
        );
          },
        );
      },
    );
  }
