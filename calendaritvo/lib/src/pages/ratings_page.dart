import 'package:calendaritvo/src/bloc/Materias_bloc.dart';
import 'package:calendaritvo/src/helpers/helpers.dart';
import 'package:calendaritvo/src/models/materia_model.dart';
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
        final materia = snapshot.data;
        if (materia.length == 0) {
          return Center(
            child: Text("No hay materias"),
          );
        }
        return ListView.builder(
            itemCount: materia.length-1,
            
            itemBuilder: (BuildContext context, int i){
              final index=i+1;
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
                    child: Card(
                       child: Stack(
                         children: [                     
                           Container(
                             color: Theme.of(context).backgroundColor,//Colors.black12,
                             child: ListTile(                                                                         
                                title: Text("${materia[index].name}",style:TextStyle(color: Colors.white, fontSize: 22.0) ),
                                subtitle: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Hero(
                                      tag: materia[index].id,
                                      child: Text("Promedio actual : 90",style:TextStyle(color: Colors.white, fontSize: 15.0),)),
                                  ],
                                ),
                                trailing: Icon(FontAwesomeIcons.sortAmountDown, color: Colors.white,),
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
                  (dropM==materia[index].id)?_ListC(materia: materia[index],):Container(),
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
    return Container(     
       color: Colors.white70,
      //  margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
            return 
                Stack(
                  children: [                    
                ListTile(
                       leading: Icon(FontAwesomeIcons.edit),
                      title: Text("primer parcial"),
                      trailing: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text("5",style: TextStyle(fontSize: 40, fontWeight:FontWeight.bold ),)),                              
            ),
                  ],
                );
           },
          ),
          Hero(
            tag: materia.id,
            child: Container(
              child: Text("Promedio final: ",style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold ),),
            ),
          )
        ],
      ),
    );
  }
}