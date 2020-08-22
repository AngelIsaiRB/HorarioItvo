

import 'dart:async';

import 'package:calendaritvo/src/models/materia_model.dart';
import 'package:calendaritvo/src/provider/db_provider.dart';

class MateriasBlock{


  static final MateriasBlock _singleton = new MateriasBlock._internal();

  MateriasBlock._internal(){
  obtenerMaterias();
  }
  factory MateriasBlock(){
    return _singleton;
  }

  final _materiasController = StreamController<List<MateriaModel>>.broadcast();

  Stream<List<MateriaModel>> get materiasStream => _materiasController.stream;

  dispose(){
    _materiasController?.close();
  }

  obtenerMaterias() async{
    _materiasController.sink.add(await DBProvider.db.getTodasMaterias());
  }

  agregarMateria(MateriaModel materia) async{
    await DBProvider.db.nuevaMateria(materia);
    obtenerMaterias();
  }

  deleteMateria(MateriaModel materia) async{
    await DBProvider.db.deleteMateria(materia);
    obtenerMaterias();
  }

  

  
}