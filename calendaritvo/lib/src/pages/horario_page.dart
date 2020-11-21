
import 'package:animate_do/animate_do.dart';
import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:calendaritvo/src/bloc/Materias_bloc.dart';
import 'package:calendaritvo/src/helpers/helpers.dart';

import 'package:calendaritvo/src/models/dias_model.dart';
import 'package:calendaritvo/src/models/materia_model.dart';
import 'package:calendaritvo/src/provider/db_provider.dart';
import 'package:calendaritvo/src/provider/notificatios_local_provide.dart';

import 'package:flutter/material.dart';
import 'package:calendaritvo/src/utils/colos_string.dart' as utils;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HorarioPage extends StatefulWidget {
  @override
  _HorarioPageState createState() => _HorarioPageState();
  
}
List<String> _dayNames=["Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Domingo"];

//List<String> _images=["assets/house.jpg","assets/house.jpg","assets/glob.jpg","assets/scroll-1.png","assets/glob.jpg","assets/scroll-1.png","assets/glob.jpg"];
class _HorarioPageState extends State<HorarioPage> {
   String day=_dayNames[DateTime.now().weekday-1];
   Color thema;      
   final materiasBloc = MateriasBlock();  
   //final diabloc = DiaBloc();
   double mitadDePantalla;
   final pref= PreferenciasUsuario();
   int _colorThema;
   int _formIcon;
   bool _selectorProgress;
  // String image=_images[DateTime.now().weekday-1];
  @override
  Widget build(BuildContext context) {
    
   mitadDePantalla =MediaQuery.of(context).size.width * 0.4;
  _colorThema = pref.tema;
  _formIcon=pref.formIcon;
  _selectorProgress=pref.progressBar;
   // materiasBloc.obtenerMaterias();
    //diabloc.obtenerDia("Lunes");
    return  Stack(
      children: [        
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            title: Text(day,style: Theme.of(context).textTheme.headline3 ,),
            centerTitle: true,
            actions: [
              // Container(
              //   margin: EdgeInsets.only(right: 10.0),
              //   child: IconButton(
              //     icon: Icon (Icons.add_circle,size: 40.0,color: Theme.of(context).primaryColor,),
              //     onPressed: (){
              //       Navigator.pushNamed(context, "addMateria");
              //     },
              //     ),
              // )
            ],
            
          ), 
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: BounceInDown(            
            child: FloatingActionButton.extended(     
              backgroundColor: Theme.of(context).primaryColor,
              heroTag: "s",       
              label: Text("Nueva materia"),
               icon:Container(                
                 child: Icon (Icons.add,size: 40.0,color:Colors.white,),                                   
               ),
               onPressed: (){
                     notificationPlugin.scheduleWeeklyMondayTenAMNotification();
                    //  notificationPlugin.cancelNotification(0);                                        
                     Navigator.pushNamed(context, "addMateria");
               },
            ),
          ),
            body: Stack(
            children: [                   
              imagenFondo(),             
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: FutureBuilder(
                      future: DBProvider.db.getHorasDias(),                  
                      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                        if(snapshot.hasData){
                           return  PageView(              
                  scrollDirection: Axis.horizontal,             
                  controller: PageController(
                    initialPage: DateTime.now().weekday-1,
                  ),
                  children: [    
                    _day("Lunes", snapshot.data[0]),
                    _day("Martes", snapshot.data[1]),
                    _day("Miercoles", snapshot.data[2]),
                    _day("Jueves", snapshot.data[3]),
                    _day("Viernes", snapshot.data[4]),
                    _day("Sabado", snapshot.data[5]),
                     Container(
                      color: Colors.black26,
                      child: Center(
                        child: Text("¡  Descansa! te lo mereces", style:TextStyle(fontSize: 40.0)),
                      ),
                    ),              
                  ],
                  onPageChanged:(index){
                   
                      setState(() { 

                        day=_dayNames[index];
                       // image=_images[index+1];
                      });
                  },              
                );
                        }
                        return Container();
                      },
                    ),
                    
              ),
               
            ],
          ),     
        ),
         (pref.welcomePage)?_ayudaCambiarHora():Container(),
      ],
    );


  }




Widget _day(String day, int horas){    
  //DBProvider.db.getHorasDias();
  return Container(    
    child: FutureBuilder(
      future: DBProvider.db.getDia(day) ,            
      builder: (BuildContext context, AsyncSnapshot<List<DiaModel>> snapshot){
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final dia = snapshot.data;
        
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: horas+1,
          controller: ScrollController(initialScrollOffset: (DateTime.now().hour-7)*60.0),
          itemBuilder: (BuildContext context, int index) {            
          return Container(          
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  _alertMaterias(context,dia[index],day);
                },
                onLongPress: (){
                  seleccionarHora(context,day, dia[index]);
                },
                child: (index!=horas)?_tarjetas(index,barProgress(index,dia[index]),dia[index],day):addButtonHora(day,horas)
                ),                
                
                
              SizedBox(height: 1.0,)
            ],
          ),
        );
         },
        );
      },
    ),
   
  );
  
} 

seleccionarHora(context,String day, DiaModel dia)async {
  final time = await showTimePicker(
     helpText: "Escoje la hora inicial",
     confirmText: "OK",
     cancelText: "Cancelar",  
    context: context,
    initialTime: TimeOfDay(hour: (int.parse(dia.range.substring(0,dia.range.indexOf(":")))), minute: 00),
  builder: (BuildContext context, Widget child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
      child: child,
    );
  },
  );
 
  final time2 = await showTimePicker(
    helpText: "Escoje la hora final",
    confirmText: "OK",    
    cancelText: "Cancelar",    
    context: context,
    initialTime: TimeOfDay(hour: time!=null?time.hour+1:00, minute:time!=null?time.minute:00),    
    builder: (BuildContext context, Widget child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
      child: child,
    );
  },
  );
  if(time!=null && time2!=null){
    //"${time.hour}:${time.minute}-${time2.hour}:${time2.minute}"
    setState(() {
    DBProvider.db.actualizarRangedeHoras(day,"${time.hour}:${time.minute}-${time2.hour}:${time2.minute}",dia.id);      
    });
  }
  
}

Widget addButtonHora(String day, int horas){
 
    return Container(
      padding: EdgeInsets.only(bottom: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          (horas!=1)?Container(
          
          decoration: BoxDecoration(
            color: Color.fromRGBO(153, 0, 0, 0.8),
            borderRadius: BorderRadius.circular(50)
          ),
          child: FlatButton(
            onPressed: (){
                setState(() {
                DBProvider.db.restarNumeroDeHoras(day, horas);            
                });
            },
            child: Icon(Icons.delete_forever,color:Colors.white),
          ),
         ):Container(),
          (horas!=12)?Container(        
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 38, 77, 0.8),
            borderRadius: BorderRadius.circular(70)
          ),
          child: FlatButton(
            onPressed: (){
                setState(() {
                DBProvider.db.agregarNumeroDeHoras(day, horas);            
                });
            },
            child: Icon(Icons.add,color:Colors.white,),
          ),
         ):Container(),
         
        ],
      ),
    );
  
  
}

double barProgress(int index, DiaModel dia){
 String z=dia.range;
 z= z.replaceAll("-", ":");
 List<String> lista=z.split(":");
 int hinicial=int.parse(lista[0]);
 int minicial=int.parse(lista[1]);
 int hfianl=  int.parse(lista[2]);
 int mfinal=  int.parse(lista[3]);
DateTime horaActual=DateTime.now();
DateTime a=DateTime(horaActual.year,horaActual.month,horaActual.day,hinicial,minicial);
DateTime b=DateTime(horaActual.year,horaActual.month,horaActual.day,hfianl,mfinal);
/*
   valor  "a" . compare ("fecha") 
  si a es antes que la "fecha" devulve -1                     R:-1 -----------(compare(X)------------- R:1)
  si a es despues de "fecha" regresa un 0 
 */
if((a.compareTo(horaActual)==-1)&&(b.compareTo(horaActual)==1)){
 int x=horaActual.difference(a).inMinutes;
 //print(x/b.difference(a).inMinutes);
 return x/b.difference(a).inMinutes;
}
  return (a.compareTo(horaActual)<0)?1.0:0.0;

  

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

BorderRadius _selecFormCard(int valor){
   if(valor==1){
   return   BorderRadius.circular(0.0);
   }
   else{
     return BorderRadius.circular(20.0);
   }
   
 }

Widget _tarjetas(int index, double vaslor,DiaModel dia,String day){  
  
  index+=7;
  if (_colorThema==1){
     thema=utils.stringToColor(dia.color);
  }
  else if(_colorThema==2){
     thema =Theme.of(context).backgroundColor;
  }
  else{
    thema=Colors.black38;
  }
  return Container(
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
                 _selectForm(_formIcon,utils.stringToColor(dia.color)),                  
                Column(                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${dia.range} Hrs", style:Theme.of(context).textTheme.subtitle2),                      
                    Container(
                      width: mitadDePantalla,
                      child: Text(dia.materia,style:TextStyle(color: Colors.white, fontSize: 20.0)  ,maxLines: 1 ,)),
                  ],
                ),
                 Column(
                   children: [                     
                     Container(                      
                       child: Icon(FontAwesomeIcons.angleDown,size: 40.0, color: Theme.of(context).primaryColor,)),
                   ],
                 ),
              ],
            ),
            SizedBox(height: 15.0,),
            linearProgressSelector(vaslor,_selectorProgress),
          ],
        )
      ),
    ),
  );
}
 
 Widget linearProgressSelector(double vaslor,bool valible){
   if (valible){
     return LinearProgressIndicator(                 
              value:vaslor,
              minHeight: 12.0,
              backgroundColor: Colors.red[100],
              valueColor:new AlwaysStoppedAnimation<Color>(Colors.greenAccent),                                
            );
   }
   return Container();
 }
  
_alertMaterias(BuildContext context,DiaModel dia,String day){
  showDialog(
    context: context,
    barrierDismissible: true, 
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).canvasColor,
        title: Text("Selecciona materia"),
        content: Container(          
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: _listViewMaterias(dia,day)
                )
            ],
          )
           ),
        actions: [
          FlatButton(
            onPressed: (){
               Navigator.pushNamed(context, "addMateria");
            },
            child: Text("Agregar materia", style: TextStyle(fontSize: 20.0),),
          )
        ],
        
      );
      
    },
    );
}

Widget _listViewMaterias(DiaModel dia,String day) {
  materiasBloc.obtenerMaterias();
    return StreamBuilder(
      stream: materiasBloc.materiasStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<MateriaModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final materia = snapshot.data;
        if (materia.length == 1) {
          return Center(
            child: Text("No hay materias"),
          );
        }
        return ListView.builder(
          itemCount: materia.length,
          itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.fiber_manual_record, color: utils.stringToColor(materia[index].color),),
            title: Text(materia[index].name, style: Theme.of(context).textTheme.bodyText1,),
            onTap: (){              
              DBProvider.db.actualizarHora(dia.id, materia[index].name, day);
              Navigator.pop(context);
              setState(() {
                
              });
            },
          );
         },
        );
      },
    );
  }

 Widget _ayudaCambiarHora() {
   return GestureDetector(
        onTap: (){
          setState(() {
          pref.welcomePage=false;
            
          });
        },
        child: Container(  
        color:Color.fromRGBO(0, 0, 0, 0.9),   
       child: Column(       
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
           Container(
             
           ),
           Container(                     
             margin: EdgeInsets.all(10),
             child: Text("Manten presionado un modulo para cambiar la hora", style: TextStyle(fontSize: 30,color: Colors.white),),           
           ),
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50)
            ),
            child: Text("OK"),
          )
         ],
       ),
     ),
   );
 }

  

}