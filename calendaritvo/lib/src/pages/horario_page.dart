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
   double _valorporciento=0;
   final materiasBloc = MateriasBlock();  
   final diabloc = DiaBloc();
   double mitadDePantalla;
   
  // String image=_images[DateTime.now().weekday-1];
  @override
  Widget build(BuildContext context) {
   mitadDePantalla =MediaQuery.of(context).size.width * 0.4;
  
   // materiasBloc.obtenerMaterias();
    //diabloc.obtenerDia("Lunes");
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: Text(day,style: TextStyle(color:Colors.black,fontSize:35.0, fontStyle: FontStyle.italic  ),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon (Icons.add_circle,size: 30.0,color: Colors.black,),
            onPressed: (){
              Navigator.pushNamed(context, "addMateria");
            },
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
      image:AssetImage("assets/fondo6.jpg"),
      fit: BoxFit.cover,
   ),
    
  );
}

Widget _day(String day){    
   
  return  Container(    
    child: FutureBuilder(
      future: DBProvider.db.getDia(day) ,
      //initialData: initialData ,
      builder: (BuildContext context, AsyncSnapshot<List<DiaModel>> snapshot){
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final dia = snapshot.data;
        
        return ListView.builder(
          itemCount: dia.length,
          itemBuilder: (BuildContext context, int index) {
          return Container(          
          child: Column(
            children: [
              _tarjetas(index, _valorporciento,dia[index],day),
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

void barProgress(int index){
if(index == DateTime.now().hour-7){
   
        _valorporciento=DateTime.now().minute/60;
        }
        else{
          if(index < DateTime.now().hour-7)
          _valorporciento=1.0;
          else
           _valorporciento=0.0;

        } 

}

Widget _tarjetas(int index, double vaslor,DiaModel dia,String day){  
  index+=7;
  if (1==1){
     thema=utils.stringToColor(dia.color);
  }
  else{
     thema = Theme.of(context).backgroundColor;
  }
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),        
        child: Container(        
           color: thema,
        child: Column(          
          children: [
            SizedBox(height: 4.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.fiber_manual_record,size: 35.0, color: utils.stringToColor(dia.color),),                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$index:00-${index+1}:00 Hrs", style:Theme.of(context).textTheme.subtitle2),
                    Container(
                      width: mitadDePantalla,
                      child: Text(dia.materia,style:Theme.of(context).textTheme.bodyText1,maxLines: 1 ,)),
                  ],
                ),
                 Column(
                   children: [                     
                     _crearDropdown(context,dia,day)
                   ],
                 ),
              ],
            ),
            SizedBox(height: 15.0,),
             LinearProgressIndicator(               
              value:vaslor,
              minHeight: 10.0,
              backgroundColor: Colors.red[100],
              valueColor:new AlwaysStoppedAnimation<Color>(Colors.green),                                
            ),
          ],
        )
      ),
    ),
  );
}
 
 
 
 
  

  Widget _crearDropdown(BuildContext context, DiaModel dia,String day) {
    return Container(
            child: FlatButton(
              onPressed: (){
                _alertMaterias(context,dia,day);
              },
              child: Icon(Icons.arrow_drop_down_circle,size: 40.0, color: Theme.of(context).primaryColor,),
            )
          );
  }



_alertMaterias(BuildContext context,DiaModel dia,String day){
  showDialog(
    context: context,
    barrierDismissible: true, 
    builder: (context) {
      return AlertDialog(
        title: Text("Escoje materia"),
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
        if (materia.length == 0) {
          return Center(
            child: Text("No hay materias"),
          );
        }
        return ListView.builder(
          itemCount: materia.length,
          itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.fiber_manual_record, color: utils.stringToColor(materia[index].color),),
            title: Text(materia[index].name, style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              backgroundColor: Colors.transparent
                 ),),
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