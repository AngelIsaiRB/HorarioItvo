import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calendaritvo/src/bloc/Materias_bloc.dart';
import 'package:calendaritvo/src/bloc/calificaiones_bloc.dart';
import 'package:calendaritvo/src/data/data_list.dart';
import 'package:calendaritvo/src/helpers/helpers.dart';
import 'package:calendaritvo/src/models/calificacion_model.dart';
import 'package:calendaritvo/src/models/materia_model.dart';
import 'package:calendaritvo/src/provider/db_c_provider.dart';
import 'package:calendaritvo/src/utils/colos_string.dart' as utils;

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final materiasBloc = MateriasBlock();
  final calificacionesBlock = CalificacionesBlock();
 int dropM=0;



  @override
  Widget build(BuildContext context) {
     materiasBloc.obtenerMaterias();
    
    return Scaffold(
      appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            title: Text("Calificaciones",style: Theme.of(context).textTheme.headline3 ,),
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
              imagenFondo(),
              _listViewMaterias(),
            ],
          ),
    );
  }

    Widget _listViewMaterias() {
    return StreamBuilder(
      stream: materiasBloc.materiasStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<MateriaModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final materias = snapshot.data;
        if (materias.length == 0) {
          return Center(
            child: Text("No hay materias"),
          );
        }
        return ListView.builder(
            itemCount: materias.length-1,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int i){
              final index=i+1;
              final materia= materias[index];
              return Column(                
                children: [                  
                  GestureDetector(
                    onTap: (){                      
                      setState(() {
                      if(dropM==materia.id)
                      this.dropM=0;
                      else
                      this.dropM=materia.id;                        
                      });
                    },
                    child: Card(
                       child: Stack(
                         children: [                     
                           Container(
                             color: Theme.of(context).backgroundColor,//Colors.black12,
                             child: ListTile(                                                                         
                                title: Text("${materia.name}",style:TextStyle(color: Colors.white, fontSize: 25.0) ),
                                leading: FutureBuilder(
                                  future: DbCProvider.db.promedioCalificacion(materia.id),                                  
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if(!snapshot.hasData){
                                      return Text("...",style:TextStyle(color: Colors.white, fontSize: 25.0)) ;
                                    }
                                    return Text("${snapshot.data.toStringAsFixed(1)}",style:TextStyle(color: Colors.white, fontSize: 25.0)) ;
                                  },
                                ),
                                trailing: Icon(FontAwesomeIcons.sortAmountDown, color: utils.stringToColor(materia.color),),
                              ),
                           ),
                           Container(
                             width: double.infinity,
                             height: 5,
                             color: utils.stringToColor(materia.color),
                           ),
                         ],
                       ),                                 
                    ),
                  ),
                  (dropM==materia.id)?_ListC(materia: materia,):Container(),
                ],
              );
            }
                  );
      },
    );
  }
}

class _ListC extends StatelessWidget {
  final MateriaModel materia;

  const _ListC({Key key, this.materia}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final calificacionesBlock = CalificacionesBlock();
   
    calificacionesBlock.obtenerCalificacionesDeMateria(materia.id);    
    return StreamBuilder(
      stream: calificacionesBlock.calificacionMateria,      
      builder: (BuildContext context, AsyncSnapshot<List<CalificacionModel>> snapshot) {
         if (!snapshot.hasData ){
           return Container();
         }
        final mate = snapshot.data;
        
         double promedio=0;        
         if(mate.length>=1){
           mate.forEach((element) {
           promedio = promedio + element.calificacion;
        });
        promedio=promedio/mate.length;
         }
        return Container(
          color: Colors.white70,
          child: Column(
        children: [
          ////////////////////////////////////////////////////
          _buildListViewCalific(mate, calificacionesBlock),
          ////////////////////////////////////////////////////
           Container(
              child: Text("Promedio final: ${promedio.toStringAsFixed(1)}",style: TextStyle(color: Theme.of(context).shadowColor,fontSize: 25, fontWeight:FontWeight.bold ),),
            ),          
            ////////////////////////////////////////////////////
          _buildMaterialButtonAgregarCalif(context, calificacionesBlock)
            ////////////////////////////////////////////////////
        ],
      ),
        );
      },
    );
   
  }

  MaterialButton _buildMaterialButtonAgregarCalif(BuildContext context, CalificacionesBlock calificacionesBlock) {
    return MaterialButton(
          child: Text("Agregar Calificacion",style:TextStyle(color: Colors.white, fontSize: 15.0),),
          color: Colors.black38,
          onPressed: ()async{
            mostrarAlertaAgregarCalificacion(context: context, 
            title: "Agregar Calificacion",
            textAceptar: "Aceptar",
            onOk: (String value){
              try {
                final valuebol = double.parse(value);
                final calificacion = CalificacionModel(calificacion:valuebol, idMateria: materia.id,semestre: "" );                 
               calificacionesBlock.agregarCalificacion(calificacion);
               Navigator.of(context).pop();
              }
              catch(e){ }
            }
            ); 
          },
          );
  }

  ListView _buildListViewCalific(List<CalificacionModel> materias, CalificacionesBlock calificacionesBlock) {
    
    return ListView.separated(    
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: materias.length,
        itemBuilder: (BuildContext context, int index) {
          final materia=materias[index];
          if(index>=49){
          return Container();
        }
        return 
            Stack(
              children: [                    
            GestureDetector(
              onTap: (){
                alertYesNo(
                  context: context,
                  mensaje: "Desea Eliminar",
                  onYes: (){
                    final model = CalificacionModel(id:materia.id ,idMateria: materia.id);
                    calificacionesBlock.eliminarCalificacion(model);
                    Navigator.of(context).pop();
                  },
                  onNo: () => Navigator.of(context).pop()
                );
                 
              },
                child: ListTile(
                       leading: Container(
                         color: Colors.black12,
                         child: IconButton(                                                     
                           icon: Icon(FontAwesomeIcons.edit, color: Theme.of(context).shadowColor,),
                           onPressed: (){
                             mostrarAlertaAgregarCalificacion(
                               context: context,
                               title: "Editar calificacion",
                               textAceptar: "Cambiar",
                               onOk: (value){
                                 try {
                                 final cal=double.parse(value);
                                final model = CalificacionModel(id:materia.id, idMateria:materia.idMateria,calificacion: cal );
                                calificacionesBlock.actualizarCalificacion(model);
                                Navigator.of(context).pop();                                     
                                 } catch (e) {
                                 }
                               }
                             );
                           },
                           ),
                       ),
                      title: Text("${ordinalNumber[index]}:",style: TextStyle(color: Theme.of(context).shadowColor,fontSize: 18, fontWeight:FontWeight.bold ),),
                      subtitle: Text("Tap para borrar",style: TextStyle(color: Theme.of(context).shadowColor,fontSize: 13),),
                      trailing: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text("${materia.calificacion}",style: TextStyle(color: Theme.of(context).shadowColor,fontSize: 23, fontWeight:FontWeight.bold ),)),                              
        ),
              ),
           
              ],
            );
       },
       separatorBuilder: (context, i){
         return Divider(
           height: 20,
           color: Colors.black,
         );
       },
        );
  }
}