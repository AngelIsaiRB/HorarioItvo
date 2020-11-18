import 'package:animate_do/animate_do.dart';
import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:flutter/material.dart';

class SwitchColor extends StatefulWidget {
  @override
  _SwitchColorState createState() => _SwitchColorState();
}

class _SwitchColorState extends State<SwitchColor> {
  final pref = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Colores", style: Theme.of(context).textTheme.headline2,),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
      ),
  body: _switchColor(),
    );
  }

  Widget _switchColor(){
    return GridView.count(
      primary: false,
    padding: const EdgeInsets.all(20),
    crossAxisSpacing: 20,
    mainAxisSpacing: 20,
    crossAxisCount: 3,
    children: [
      _colorSelect(888, Colors.black, Colors.white),
      _colorSelect(0,Colors.pink,Colors.pink[50]),
      _colorSelect(1,  Colors.teal, Colors.teal[50]),
      _colorSelect(8,Colors.blue, Colors.blue[50]),
      _colorSelect(4, Colors.purple[50], Colors.yellow),  
      _colorSelect(3, Color.fromRGBO(255, 218, 125, 1), Colors.purple),
      _colorSelect(2, Colors.pink[200], Color.fromRGBO(47, 58, 86, 1)),
      _colorSelect(5, Color.fromRGBO( 234, 95, 64, 1), Color.fromRGBO( 31, 78, 90, 1)),
      _colorSelect(6, Color.fromRGBO( 230, 242, 238, 1), Color.fromRGBO( 20, 102, 75, 1)),
      _colorSelect(7, Color.fromRGBO( 118, 96, 146, 1), Color.fromRGBO( 231, 211, 238, 1))
    ],
    );



   

}
    Widget _colorSelect(int value, Color color1, Color color2){
      return GestureDetector(
            onTap: (){
              
              pref.colorApp=value; 
              Navigator.pushReplacementNamed(context, "restart"); 
            },
            child: FadeInRight(
              duration: Duration(milliseconds: 500),
              child: Container(  
                height: 50.0,
                width: 50.0,          
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient:  LinearGradient(
                   begin: FractionalOffset(0.6,0.0) ,
                   end:   FractionalOffset(0.0,0.2),                  
                   colors: [
                     color1,color2
                   ]
                  ),

                ),
                
              ),
            ),
          );
    }

}