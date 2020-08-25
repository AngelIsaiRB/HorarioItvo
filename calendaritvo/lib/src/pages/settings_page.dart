import 'package:calendaritvo/main.dart';
import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _tema;
  bool _colorSecundario;
  final pref = PreferenciasUsuario();

  @override
  void initState() { 
    super.initState();
    _tema=pref.tema;
    _colorSecundario=pref.secundaryColor;
  }

  _selectedTema(int value){
    pref.tema=value;
    _tema=value;setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes", style: TextStyle(fontSize: 50.0, color: Colors.black),),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Container(        
       child: ListView(
         children: [      
           Container(
            child: Text("Tema",style: TextStyle(color: Colors.black, fontSize: 40.0), ),
          ),               
           Container(            
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width *0.4,
                  height: MediaQuery.of(context).size.width * 0.7,
                  child: Image(image: AssetImage("assets/tema1.jpg"), )),
                Container(
                  width: MediaQuery.of(context).size.width *0.4,
                  height: MediaQuery.of(context).size.width * 0.7,
                  child: Image(image: AssetImage("assets/tema2.jpg"),  )), 
              ],
          ),
           ),
           Container(           
            child:Row(
             children: [
               Container(                 
                 width: MediaQuery.of(context).size.width *0.5,
                 child: RadioListTile(                         
                        value: 1,
                        title: Text("Rigel"),
                        groupValue: _tema,
                         onChanged: (value){
                           _selectedTema(value);
                         },
                     ),
               ),
               Container(                 
                 width: MediaQuery.of(context).size.width *0.5,
                 child: RadioListTile(  
                   activeColor: Theme.of(context).primaryColor,                       
                        value: 2,
                        title: Text("Betelgeuse"),
                        groupValue: _tema,
                         onChanged: (value){
                           _selectedTema(value);
                         },
                     ),
               ),
             ], 
            )
          ),
           Divider(color: Theme.of(context).primaryColor,),
          Container(
            child: Text("Color",style: TextStyle(color: Colors.black, fontSize: 40.0), ),
          ),
          SwitchListTile(
            inactiveTrackColor: Theme.of(context).primaryColor,
            activeColor: Colors.teal,
            value: _colorSecundario,
            title: Text("Color secundario"),
            onChanged: (value){
              setState(() {
              _colorSecundario=value;
              pref.secundaryColor=value;    
              ThemeData.dark();
              });
            },
          ),

                                   
              
            
         
         ],
       )
    ),
    );
  }
}