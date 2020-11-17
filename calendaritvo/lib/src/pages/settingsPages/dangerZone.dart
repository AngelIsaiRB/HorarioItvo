import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:calendaritvo/src/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DangerZone extends StatefulWidget {
  @override
  _DangerZoneState createState() => _DangerZoneState();
}

class _DangerZoneState extends State<DangerZone> {
  final pref = PreferenciasUsuario();
  bool _menu;
   @override
  void initState() { 
    super.initState();
    
    _menu=pref.menu;
       
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("Zona Roja", style: Theme.of(context).textTheme.headline2,),
         backgroundColor: Theme.of(context).primaryColorLight,
         centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            _notificaciones(),
            _deleteMenu(),
              _restaurar(),
              _info()
          ],
        ),
      ),
    );
  }
  Widget _notificaciones() {
    return Container(
      margin: EdgeInsets.only(left: 5,right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Desactivar notificaciones"),
          FlatButton(
            color: Colors.blueAccent,
            child: Icon(Icons.alarm_off),
            onPressed: ()async{              
              await openAppSettings();
            },
          ),
        ],
      ),
    );
  }
   Widget _deleteMenu(){
    return Column(
      children: [
        Row(
            children: [
              Container(
                margin: EdgeInsets.only(left:15.0 ),
                color: Color.fromRGBO(48, 48, 48, 1.0),
                child: Icon(Icons.warning,size: 50.0, color: Colors.yellow,)),
              Text("Menu",style: Theme.of(context).textTheme.headline2,),
            ],
          ),
        Container(
         
          child: SwitchListTile(            
                  value: _menu, 
                  title: Text("Quitar Noticias"),
                  subtitle: Text("Si no eres parte del ITVO o no te interesan las noticias"),
                  onChanged: (value){
                    setState(() {
                        _menu=value;
                        pref.menu=value;           
                    });
                    Navigator.pushReplacementNamed(context, "homepage");
                  },
                ),
        ),
      ],
    );
  }
  _restaurar(){
      return Container(
        margin: EdgeInsets.only(left: 50,right:50 ),
        color: Colors.red,
        child: FlatButton(
          onPressed: (){
            final snackBar = SnackBar(content: Text('Manten presionado'),
            duration: Duration(milliseconds: 1000),);
           Scaffold.of(context).showSnackBar(snackBar);

          },
          onLongPress: (){
            showDialog(
             context: context,
             barrierDismissible: true,
             builder: (context){
                 return  AlertDialog(
                   title: Text("¿Eliminar Materias, horario y restablecer?"),
                   actions: [
                     FlatButton(
                       child: Container(
                         color: Colors.redAccent,
                         padding: EdgeInsets.all(15),
                         child: Text("Si")),
                       onPressed: (){
                       DBProvider.db.eliminarDB();                       
                       Navigator.pop(context);
                       },
                     ),
                     FlatButton(
                       child: Text("No"),
                       onPressed: (){
                         Navigator.pop(context);
                       },
                     ),
                   ],
                 );
             });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.warning),
              Text("Restablecer Horario",style: TextStyle(fontSize: 20),),
            ],
          ),
        ),
      );
    }

    Widget _info(){
      return Container(
             color: Theme.of(context).cardColor,
            margin: EdgeInsets.all(10.0),
            child: Text("Version 1.5.1   ⛔"
                 "Esta version no guarda tu horario en la nube "
                 "¡ten cuidado al limpiar el caché o datos de la App!",style: Theme.of(context).textTheme.subtitle1 
                 ),
          );
    }
}