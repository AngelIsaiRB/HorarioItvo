import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calendaritvo/src/pages/settingsPages/dangerZone.dart';
import 'package:calendaritvo/src/pages/settingsPages/developer.dart';
import 'package:calendaritvo/src/pages/settingsPages/extraSetings.dart';
import 'package:calendaritvo/src/pages/settingsPages/imagefond.dart';
import 'package:calendaritvo/src/pages/settingsPages/switchColor.dart';
import 'package:calendaritvo/src/pages/settingsPages/themaSelector.dart';
import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';




class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
 
  
  
  final pref = PreferenciasUsuario();
 
  

  @override
  void initState() { 
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Ajustes", style: Theme.of(context).textTheme.headline2,),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      
      body: Container(          
       child: ListView(
         physics: BouncingScrollPhysics(),
         children: [ 
              listItem(FontAwesomeIcons.image,Colors.blueAccent,"Imagen"                    ,ImageFonda() ),              
              listItem(FontAwesomeIcons.paintRoller,Colors.purple,"Tema"               ,TemaSelector() ),              
              listItem(FontAwesomeIcons.palette,Colors.green,    "Colores"            ,SwitchColor() ),              
              listItem(FontAwesomeIcons.shapes,Colors.red[300],       "Formas"             ,ExtraSettings() ),              
              listItem(FontAwesomeIcons.exclamationTriangle,Colors.red,"Danger Zone",DangerZone() ),              
              listItem(FontAwesomeIcons.userAstronaut,Colors.cyan,"Developer"        ,Developer() ),
              
         ],
         
       )
    ),
    ); 
  }

 Widget listItem(IconData icon,Color color,String title, Widget ruta){
   return Container(
     padding: EdgeInsets.symmetric(vertical: 5),
     child: Container(
        // color: Theme.of(context).primaryColor,
       child: ListTile(
          title: Text(title, style: TextStyle(fontSize: 22, letterSpacing: 3),),
          leading: Icon(icon, size: 25,color:color,),
          trailing: Icon(FontAwesomeIcons.angleRight,color: Colors.black45,),
          onTap: (){
            Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 200),
                      type: PageTransitionType.rightToLeft,
                      child: ruta,
                    ),
                  );
          },
       ),
     ),
   );
 }



}