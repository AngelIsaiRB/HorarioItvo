import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:flutter/material.dart';

class ExtraSettings extends StatefulWidget {
  @override
  _ExtraSettingsState createState() => _ExtraSettingsState();
}

class _ExtraSettingsState extends State<ExtraSettings> {
   int _formIcon;
   bool _progressBar;
   final pref=PreferenciasUsuario();
  @override
  void initState() { 
    super.initState();
    
    _formIcon=pref.formIcon;
    _progressBar = pref.progressBar;
  }
   _selectFormIcon(int value){
    pref.formIcon=value;
    setState(() {
      _formIcon=value;
    });
  }
    _selectProgressBar(bool value){
    pref.progressBar=value;
    setState(() {
      _progressBar=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("Extra", style: Theme.of(context).textTheme.headline2,),
         backgroundColor: Theme.of(context).primaryColorLight,
         centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            _iconForm(),
            _progressBarSelector(),
          ],
        ),
      ),
    );
  }
  Widget _iconForm(){
    return Column(
      children: [
        Container(            
            alignment: AlignmentDirectional.topStart,
            child: Text("Icono / tarjeta",style: Theme.of(context).textTheme.headline2,)),
        Container(
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                      color: Colors.pink,//utils.stringToColor(dia.color),
                      child: SizedBox(width: 45.0,height: 45.0,),
                    ),
                    Container(                 
                     width: MediaQuery.of(context).size.width *0.5,
                     child: RadioListTile(  
                       activeColor: Theme.of(context).primaryColor,                         
                            value: 1,
                            title: Text("Cuadrado"),
                            groupValue: _formIcon,
                             onChanged: (value){
                               _selectFormIcon(value);
                             },
                         ),
                        ),
                ],
              ),
              Column(
                children: [
                  Container(
                      //utils.stringToColor(dia.color),
                      child: Icon(Icons.fiber_manual_record, color: Colors.pink,size: 45.0, ),
                    ),
                    Container(                 
                     width: MediaQuery.of(context).size.width *0.5,
                     child: RadioListTile(    
                            activeColor: Theme.of(context).primaryColor,  
                            value: 2,
                            title: Text("Circular"),
                            groupValue: _formIcon,
                             onChanged: (value){
                               _selectFormIcon(value);
                             },
                         ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
   Widget _progressBarSelector(){
    return Column(
      children: [
        Container(            
            alignment: AlignmentDirectional.topStart,
            child: Text("Medidor de tiempo",style: Theme.of(context).textTheme.headline2,)),
        SwitchListTile(     
                activeColor: Theme.of(context).primaryColor,       
                value: _progressBar, 
                title: Text("Activar medidor"),            
                onChanged: (value){
                  _selectProgressBar(value);
                },
              ),
      ],
    );
  }
}