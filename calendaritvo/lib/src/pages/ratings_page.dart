import 'package:animate_do/animate_do.dart';
import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:calendaritvo/src/bloc/Materias_bloc.dart';
import 'package:calendaritvo/src/bloc/calificaiones_bloc.dart';
import 'package:calendaritvo/src/data/data_list.dart';
import 'package:calendaritvo/src/helpers/helpers.dart';
import 'package:calendaritvo/src/models/calificacion_model.dart';
import 'package:calendaritvo/src/models/materia_model.dart';
import 'package:calendaritvo/src/provider/db_c_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:calendaritvo/src/utils/colos_string.dart' as utils;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final materiasBloc = MateriasBlock();
  final calificacionesBlock = CalificacionesBlock();
 int dropM=0;
  final pref= PreferenciasUsuario();


  @override
  Widget build(BuildContext context) {
     materiasBloc.obtenerMaterias();
    
    return Scaffold(
      appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            title: Text("Calificaciones",style: Theme.of(context).textTheme.headline3 ,),
            centerTitle: true,                       
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Bounce(
            duration: Duration(milliseconds: 900),
            child: FloatingActionButton.extended(    
               backgroundColor: Theme.of(context).primaryColor,
              heroTag: "s",        
               label: Text("Nueva materia"),
               icon:Container(                
                 child: Icon (Icons.add,size: 40.0,color:Colors.white,),                                   
               ),
               onPressed: (){
                     Navigator.pushNamed(context, "addMateria");
               },
            ),
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
      final _thema = pref.tema;
      Color themeData;
      Color iconthemeData;
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
            itemCount: materia.length-1,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int i){
              final index=i+1;              
              if(_thema==1){
                 themeData= utils.stringToColor(materia[index].color);
                 iconthemeData = Colors.white;
              }
              else{
                themeData=Theme.of(context).backgroundColor;
                iconthemeData = utils.stringToColor(materia[index].color);
              }
              return Column(                
                children: [                  
                  GestureDetector(
                    onTap: (){                      
                      setState(() {
                      if(dropM==materia[index].id)
                      this.dropM=0;
                      else
                      this.dropM=materia[index].id;                        
                      });
                    },
                    child: FadeInUp(
                      duration: Duration(milliseconds: 150),
                      child: ClipRRect(
                        borderRadius: _selecFormCard(pref.formIcon),
                        child: Card(
                           child: Stack(
                             children: [                     
                               Container(
                                 color: themeData,//Colors.black12,
                                 child: ListTile(                                                                         
                                    title: Text("${materia[index].name}",style:TextStyle(color: Colors.white, fontSize: 25.0) ),
                                    leading: FutureBuilder(
                                      future: DbCProvider.db.promedioCalificacion(materia[index].id),                                  
                                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                                        if(!snapshot.hasData){
                                          return Text("...",style:TextStyle(color: Colors.white, fontSize: 25.0)) ;
                                        }
                                        return Text("${snapshot.data.toStringAsFixed(1)}",style:TextStyle(color: Colors.white, fontSize: 25.0)) ;
                                      },
                                    ),
                                    trailing: Icon(FontAwesomeIcons.sortAmountDown, color: iconthemeData,),
                                  ),
                               ),
                               Container(
                                 width: double.infinity,
                                 height: 5,
                                 color: utils.stringToColor(materia[index].color),
                               ),
                             ],
                           ),                                 
                        ),
                      ),
                    ),
                  ),
                  (dropM==materia[index].id)?_ListC(materia: materia[index],):Container(),
                 
                ],
              );
            }
                  );
      },
    );
  }
}
BorderRadius _selecFormCard(int valor){
   if(valor==1){
   return   BorderRadius.circular(0.0);
   }
   else{
     return BorderRadius.circular(50.0);
   }
   
 }
class _ListC extends StatelessWidget {
  final MateriaModel materia;

  const _ListC({Key key, this.materia}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final calificacionesBlock = CalificacionesBlock();
   
    calificacionesBlock.obtenerCalificacionesDeMateria(materia.id);    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),      
      child: StreamBuilder(
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
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight:Radius.circular(20) )
            ),
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
      ),
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

  ListView _buildListViewCalific(List<CalificacionModel> mate, CalificacionesBlock calificacionesBlock) {
    
    return ListView.separated(    
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: mate.length,
        itemBuilder: (BuildContext context, int index) {
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
                    final model = CalificacionModel(id:mate[index].id ,idMateria: materia.id);
                    calificacionesBlock.eliminarCalificacion(model);
                    Navigator.of(context).pop();
                  },
                  onNo: () => Navigator.of(context).pop()
                );
                 
              },
                child: FadeInDown(
                  duration: Duration(milliseconds: 100),
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
                                  final model = CalificacionModel(id:mate[index].id, idMateria: mate[index].idMateria,calificacion: cal );
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
                          child: Text("${mate[index].calificacion}",style: TextStyle(color: Theme.of(context).shadowColor,fontSize: 23, fontWeight:FontWeight.bold ),)),                              
        ),
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