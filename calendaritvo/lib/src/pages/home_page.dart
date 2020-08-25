
import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:calendaritvo/src/pages/horario_page.dart';
import 'package:calendaritvo/src/pages/info_page.dart';
import 'package:calendaritvo/src/pages/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
List<String> _dayNames=["Domingo","Lunes","Martes","Miercoels","Jueves","Viernes","Sabado"];
class _HomePageState extends State<HomePage> {
  
  
  String day=_dayNames[DateTime.now().weekday-1];
  int currentIndex=0;
  List<BottomNavigationBarItem> _menu;
  final pref =PreferenciasUsuario();
  
  @override
  Widget build(BuildContext context) {   
    if( ! pref.menu){
      _menu=[BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          title: Text("Horario"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.new_releases),
          title: Text("Noticias"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          title: Text("Ajustes"),
        )];
    }
    else{
        _menu=[BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          title: Text("Horario"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          title: Text("Ajustes"),
        )];
    }
        
    return Scaffold(           
      body:_callPage(currentIndex), 
      bottomNavigationBar: _buttonnavigationBar(context),
    );
  }
///////////////////////////////////////////////////////////////////////////
  Widget _buttonnavigationBar(BuildContext context){
  return  BottomNavigationBar(
   
    currentIndex: currentIndex,
      onTap: (index){
          setState(() {
          currentIndex =index;            
          });
      },
      items: _menu,
    );
  

}

 Widget _callPage(int paginaActual) {

    switch (paginaActual) {
      case 0:
        return HorarioPage();
        break;
      case 1:
      if(! pref.menu)
        return InfoPage();
        else
        return SettingsPage();
        break;
      case 2:
        return SettingsPage();
        break;
      default:
        return HorarioPage();
        break;
      
    }

  }
}