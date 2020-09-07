import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:calendaritvo/src/bloc/Materias_bloc.dart';
import 'package:calendaritvo/src/bloc/dias_bloc.dart';
import 'package:calendaritvo/src/models/dias_model.dart';
import 'package:calendaritvo/src/models/materia_model.dart';
import 'package:calendaritvo/src/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:calendaritvo/src/utils/colos_string.dart' as utils;

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
   final diabloc = DiaBloc();
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
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text(day,style: Theme.of(context).textTheme.headline3 ,),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon (Icons.add_circle,size: 40.0,color: Theme.of(context).primaryColor,),
              onPressed: (){
                Navigator.pushNamed(context, "addMateria");
              },
              ),
          )
        ],
        
      ), 
        body: Stack(
        children: [          
          _imagenFondo(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: PageView(              
              scrollDirection: Axis.horizontal,             
              controller: PageController(
                initialPage: DateTime.now().weekday-1,
              ),
              children: [                
                _day("Lunes",),
                _day("Martes"),
                _day("Miercoles"),
                _day("Jueves"),
                _day("Viernes"),
                _day("Sabado"), 
                Container(
                  color: Colors.black26,
                  child: Center(
                    child: Text("¡Descansa! te lo mereces", style:TextStyle(fontSize: 40.0)),
                  ),
                ),               
              ],
              onPageChanged:(index){
               
                  setState(() { 

                    day=_dayNames[index];
                   // image=_images[index+1];
                  });
              },              
            ),
          ),
        ],
      ),     
    );


  }


  Widget _imagenFondo(){    
  return Container(
    width: double.infinity,
    height: double.infinity,
    
   child: Image(
      image:AssetImage(pref.imageFond),
      fit: BoxFit.cover,
   ),
    
  );
}

Widget _day(String day){    
  
  return  Container(    
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
          itemCount: dia.length,
          controller: ScrollController(initialScrollOffset: (DateTime.now().hour-7)*60.0),
          itemBuilder: (BuildContext context, int index) {            
          return Container(          
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  _alertMaterias(context,dia[index],day);
                },
                child: _tarjetas(index,barProgress(index),dia[index],day)),
                
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

double barProgress(int index){
 
if(index == DateTime.now().hour-7){
   
        return DateTime.now().minute/60;
        }
        else{
          if(index < DateTime.now().hour-7)
          return .99;
          else
           return 0.0;

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
                    Text("$index:00-${index+1}:00 Hrs", style:Theme.of(context).textTheme.subtitle2),
                    Container(
                      width: mitadDePantalla,
                      child: Text(dia.materia,style:TextStyle(color: Colors.white, fontSize: 20.0)  ,maxLines: 1 ,)),
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

}