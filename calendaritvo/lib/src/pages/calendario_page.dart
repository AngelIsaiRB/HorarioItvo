import 'package:calendaritvo/src/models/calendario_model.dart';
import 'package:calendaritvo/src/provider/calendario_firebase_provider.dart';
import 'package:calendaritvo/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CalendarioPage extends StatelessWidget {
  

  final calendarioProvider = CalendarioFirebaseProvider();

  @override
  Widget build(BuildContext context) {
    final pantalla =MediaQuery.of(context).size;
    return Scaffold(      
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text("Calendario",  style: Theme.of(context).textTheme.headline3,),
        centerTitle: true,
      ),    
      body: _calendario(pantalla),
      drawer: MenuWidget(),
      floatingActionButton: _buttons(context),
    );
  }

  Widget _calendario(Size pantalla) {
    return FutureBuilder(
      future: calendarioProvider.cargarCalendario(),      
      builder: (BuildContext context, AsyncSnapshot<List<Calendario>> snapshot) {
        if(snapshot.hasData){
            final calendar=snapshot.data;
            return ListView.builder(   
              itemCount: calendar.length,
              scrollDirection: Axis.horizontal,              
              itemBuilder: (BuildContext context, i){
              return Container(                                          
                child: Card(
                  color: Colors.white,
                  elevation: 20.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    children: [
                      SizedBox(height: 10.0,),
                      Text("${calendar[i].mes}-${calendar[i].year}",style: TextStyle(color: Colors.black,fontSize: 30.0),),
                      Container(
                        width: pantalla.width*0.87,
                       height: pantalla.height*0.8,
                        child: FadeInImage(
                            image: NetworkImage("${calendar[i].link}"),                            
                            placeholder: AssetImage("assets/1.gif"),
                            fadeInDuration: Duration( milliseconds: 100 ),                            
                           
                                                     
                        ),
                      ),

                    ],
                  ),
                ),
              );
          },

          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        
      },
    );
  }

  Widget _buttons(BuildContext context) {
     return SpeedDial(
          // both default to 16
          marginRight: 20,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),          
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.3,          
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
          elevation: 9.0,
          shape: CircleBorder(),
          children: [            
            speddeal('Dias inhabiles',     Colors.black,  Icon(Icons.warning)),
            speddeal('Inicio de clases',   Colors.white,  Icon(Icons.arrow_forward_ios, color: Colors.blue,)),           
            speddeal('Fin de clases',      Colors.white,  Icon(Icons.arrow_back_ios,    color: Colors.blue,)),
            speddeal('Periodo vacacional', Colors.orange, Icon(Icons.sentiment_very_satisfied)),
            speddeal('Reinscripciones',    Colors.green,  Icon(Icons.add_alert)),
            speddeal('Inscripciones',      Colors.teal,   Icon(Icons.playlist_add)),
            speddeal('Actividades intersemestrales', Colors.yellow,    Icon(Icons.stop, color: Colors.yellow,)),
            speddeal('Segunda oportunidad',          Colors.pink[100], Icon(Icons.stop, color: Colors.pink[100],)),
            speddeal('Entrega de calificaciones',        Colors.cyan[600], Icon(Icons.stop, color: Colors.cyan[600],)),
          ],
        );
  }

   speddeal(String t, Color c,Icon ico){
    return  SpeedDialChild(
              child: ico,
              backgroundColor: c,
              label: t,
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),            
            );
  }
}