

import 'dart:async';
import 'package:calendaritvo/src/models/materia_model.dart';
import 'package:calendaritvo/src/provider/db_c_provider.dart';
import 'package:calendaritvo/src/provider/db_provider.dart';

class CalificacionesBlock{


  static final CalificacionesBlock _singleton = new CalificacionesBlock._internal();

  CalificacionesBlock._internal(){
  obtenerCalificaciones();
  }
  factory CalificacionesBlock(){
    return _singleton;
  }

  final _calificacionesStream = StreamController<List<MateriaModel>>.broadcast();

  Stream<List<MateriaModel>> get calificacionesStrream => _calificacionesStream.stream;

  dispose(){
    _calificacionesStream?.close();
  }

  obtenerCalificaciones() async{
     _calificacionesStream.sink.add(await DbCProvider.db.getTodasCalificaciones());
  }

  agregarCalificacion(MateriaModel materia) async{
     await DbCProvider.db.nuevaMateria(materia);
    obtenerCalificaciones();
  }

  eliminarCalificacion(MateriaModel materia) async{
    // await DBProvider.db.deleteMateria(materia);
    obtenerCalificaciones();
  }

  

  
}