import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:calendaritvo/src/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class DangerZone extends StatefulWidget {
   DangerZone({Key key}) : super(key: key);
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
      bottomSheet: _info() ,
      body: Builder(
        builder: (context)=>Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            _notificaciones(),
            Divider(),
            _deleteMenu(),
            Divider(),
              _restaurar(context),
            
          ],
        ),
      )
      )
    );
  }
  Widget _notificaciones() {
    return GestureDetector(
      onTap: ()async{
        await openAppSettings();
      },    
     child: ListTile(
       leading: Icon(FontAwesomeIcons.bellSlash),
       title:  Text("Desactivar notificaciones"),
       trailing:  FlatButton(
           color: Colors.blueAccent,
           child: Icon(FontAwesomeIcons.timesCircle),
           onPressed: ()async{              
             await openAppSettings();
           },
         ),


      ),
    );
    
  }
   Widget _deleteMenu(){
    return Column(
      children: [        
        Container(         
          child: SwitchListTile(            
                  value: _menu,             
                  secondary: Icon(FontAwesomeIcons.exclamation),      
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
  _restaurar(BuildContext context){
      return ListTile(
        title: Text("Restablecer Todo"),
        leading: Icon(FontAwesomeIcons.exclamationTriangle,color: Colors.red),
        trailing: Container(
        margin: EdgeInsets.only(left: 50,right:50 ),
        color: Colors.red,
        child: FlatButton(
          onPressed: (){
            final snackBar = SnackBar(content: Text('Manten presionado el botón',style: TextStyle(fontSize: 25),),
            duration: Duration(milliseconds: 1000),
           padding: EdgeInsets.only(bottom: 100),
            );
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
                     Container(
                       color: Colors.green,
                       child: FlatButton(
                         child: Text("No"),
                         onPressed: (){
                           Navigator.pop(context);
                         },
                       ),
                     ),
                   ],
                 );
             });
          },
          child:
               Icon(Icons.warning),
        ),
      ),
      );
    }

     Widget _info(){
      return Container(
             color: Theme.of(context).cardColor,
            margin: EdgeInsets.all(10.0),
            child: Text("Version 1.6.0   ⛔"
                 "Esta version no guarda tu horario en la nube "
                 "¡ten cuidado al limpiar el caché o datos de la App!",style: Theme.of(context).textTheme.subtitle1                  
                 ),
          );
    } 
}