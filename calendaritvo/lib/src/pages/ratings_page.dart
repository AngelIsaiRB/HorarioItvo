import 'package:calendaritvo/src/bloc/Materias_bloc.dart';
import 'package:calendaritvo/src/models/materia_model.dart';
import 'package:flutter/material.dart';
import 'package:calendaritvo/src/utils/colos_string.dart' as utils;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final materiasBloc = MateriasBlock();




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
          body: _listViewMaterias(),
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
              return Card(
                 child: Stack(
                   children: [
                     Container(
                       width: double.infinity,
                       height: 10,
                       color: utils.stringToColor(materia[index].color),
                     ),
                     ListTile(                                                
                        title: Text("${materia[index].name}",style:TextStyle(color: Colors.white, fontSize: 22.0) ),
                        subtitle: Row(
                          children: [
                            Container(
                              width: 10,
                            ),
                            Text("Promedio actual : 90",style:TextStyle(color: Colors.white, fontSize: 15.0),),
                          ],
                        ),
                        trailing: Icon(FontAwesomeIcons.arrowRight, color: Colors.white,),
                      ),
                   ],
                 ),                                 
              );
            }
                  );
      },
    );
  }
}