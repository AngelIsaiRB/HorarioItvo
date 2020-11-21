import 'package:animate_do/animate_do.dart';
import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExtraSettings extends StatefulWidget {
  @override
  _ExtraSettingsState createState() => _ExtraSettingsState();
}

class _ExtraSettingsState extends State<ExtraSettings> {
   int _formIcon=1;
   double _width =40.0;
  double _height =40.0;  
  BorderRadiusGeometry _borderradius = BorderRadius.circular(0);
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
         title: Text("Formas", style: Theme.of(context).textTheme.headline2,),
         backgroundColor: Theme.of(context).primaryColorLight,
         centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            FadeInUp(duration: Duration(milliseconds: 290),child: _iconForm()),
            Divider(),
            FadeInUp(duration: Duration(milliseconds: 320),child: _progressBarSelector()),
            Divider(),
            FadeInUp(duration: Duration(milliseconds: 350),child: _example()),
          ],
        ),
      ),
    );
  }
  Widget _iconForm(){
    return GestureDetector(
        onTap:  _cambiarForma,        
      child: Container(
        color: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top:10),
              child:Text("Forma",style: Theme.of(context).textTheme.headline2,)
            ),
            AnimatedContainer(
           duration: Duration(milliseconds: 100),
           curve: Curves.bounceIn,
           width: _width,
           height: _height,
           decoration: BoxDecoration(
             borderRadius: _borderradius,
             color: Colors.redAccent
           ),                   
         ) ,       
        Icon(FontAwesomeIcons.random,color: Theme.of(context).primaryColor,),
          ],
        ),
      ),
    );
  }
  void _cambiarForma(){  
    if(_formIcon==1){
      setState(() {           
      _borderradius = BorderRadius.circular(100);
      _selectFormIcon(2);
      _formIcon=2;
      });
    }    
    else{      
       setState(() {           
      _borderradius = BorderRadius.circular(0);
      _selectFormIcon(1);
      _formIcon=1;
      });
    }      
  }
   Widget _progressBarSelector(){
    return Column(
      children: [        
        SwitchListTile(     
                activeColor: Theme.of(context).primaryColor,       
                value: _progressBar, 
                title:Text("Medidor de tiempo",style: Theme.of(context).textTheme.headline2,),
                onChanged: (value){
                  _selectProgressBar(value);
                },
              ),
      ],
    );
  }

  //////////////////////////////////////////////
  Widget _example() {
    final pref=PreferenciasUsuario();
    final _colorThema = pref.tema;
    Color thema;
    if (_colorThema==1){
     thema=Colors.green;
  }
  else if(_colorThema==2){
     thema =Theme.of(context).backgroundColor;
  }
  else{
    thema=Colors.black38;
  }
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text("Ejemplo",style: Theme.of(context).textTheme.headline2,)),
        Container(
          padding: EdgeInsets.symmetric(vertical: 30,),
          color: Colors.white60,
          child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          child: ClipRRect(
            borderRadius: _selecFormCard(_formIcon),    //////    
              child: Container(        
                 color: thema,
              child: Column(          
                children: [
                  SizedBox(height: 4.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _selectForm(_formIcon,Colors.green),                  
                      Column(                  
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("8:00-9:00 Hrs", style:Theme.of(context).textTheme.subtitle2),                      
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Text("Programacion",style:TextStyle(color: Colors.white, fontSize: 20.0)  ,maxLines: 1 ,)),
                        ],
                      ),
                       Column(
                         children: [                     
                           Container(                      
                             child: Icon(Icons.keyboard_arrow_down,size: 40.0, color: Theme.of(context).primaryColor,)),
                         ],
                       ),
                    ],
                  ),
                  SizedBox(height: 15.0,),
                  (_progressBar)?LinearProgressIndicator(                 
                    value:0.5,
                    minHeight: 12.0,
                    backgroundColor: Colors.red[100],
                    valueColor:new AlwaysStoppedAnimation<Color>(Colors.greenAccent),                                
                  ):Container(),
                ],
              )
            ),
          ),
  ),
        ),
      ],
    );
  }
  BorderRadius _selecFormCard(int valor){
   if(valor==1){
   return   BorderRadius.circular(0.0);
   }
   else{
     return BorderRadius.circular(20.0);
   }
   
 }
 Widget _selectForm(int valor, Color color){
  if   (valor ==1){
    return  Container(
                  color: color,//utils.stringToColor(dia.color),
                  child: SizedBox(width: 45.0,height: 45.0,),
                );
  }
  else{
    return Container(
      child: Icon(Icons.fiber_manual_record, color: color,size: 45.0, ),
    );
  }
}
  
}