
import 'package:calendaritvo/src/pages/settingsPages/dangerZone.dart';
import 'package:calendaritvo/src/pages/settingsPages/developer.dart';
import 'package:calendaritvo/src/pages/settingsPages/extraSetings.dart';
import 'package:calendaritvo/src/pages/settingsPages/imagefond.dart';
import 'package:calendaritvo/src/pages/settingsPages/switchColor.dart';
import 'package:calendaritvo/src/pages/settingsPages/themaSelector.dart';
import 'package:flutter/material.dart';

import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';



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
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Container(          
       child: ListView(
         physics: BouncingScrollPhysics(),
         children: [ 
              listItem(FontAwesomeIcons.image,"Fondo"                    ,ImageFonda() ),
              listItem(FontAwesomeIcons.paintRoller,"Tema"               ,TemaSelector() ),
              listItem(FontAwesomeIcons.palette,    "Colores"            ,SwitchColor() ),
              listItem(FontAwesomeIcons.cube,       "Formas"             ,ExtraSettings() ),
              listItem(FontAwesomeIcons.exclamationTriangle,"Danger Zone",DangerZone() ),
              listItem(FontAwesomeIcons.userAstronaut,"Developer"        ,Developer() ),
         ],
       )
    ),
    ); 
  }

 Widget listItem(IconData icon,String title, Widget ruta){
   return Container(
     padding: EdgeInsets.symmetric(vertical: 5),
     child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 22),),
        leading: Icon(icon),
        trailing: Icon(FontAwesomeIcons.angleRight,color: Colors.white12,),
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
   );
 }
  


}