

import 'dart:async';
import 'package:calendaritvo/src/models/calificacion_model.dart';
import 'package:calendaritvo/src/models/materia_model.dart';
import 'package:calendaritvo/src/provider/db_c_provider.dart';
import 'package:calendaritvo/src/provider/db_provider.dart';

class CalificacionesBlock{


  static final CalificacionesBlock _singleton = new CalificacionesBlock._internal();

  CalificacionesBlock._internal(){
  obtenerCalificacionesMateria();
  }
  factory CalificacionesBlock(){
    return _singleton;
  }

  final _calificacionesStreamMaterias = StreamController<List<MateriaModel>>.broadcast();
  final _calificacionStreamMateria = StreamController<List<CalificacionModel>>.broadcast();

  Stream<List<MateriaModel>> get calificacionesStrream => _calificacionesStreamMaterias.stream;
  Stream<List<CalificacionModel>> get calificacionMateria => _calificacionStreamMateria.stream;


  dispose(){
    _calificacionesStreamMaterias?.close();
    _calificacionStreamMateria?.close();
  }

  obtenerCalificacionesMateria() async{
     _calificacionesStreamMaterias.sink.add(await DbCProvider.db.getTodasCalificacionesMaterias());
  }

  obtenerCalificacionesDeMateria(int idMateria)async{
    _calificacionStreamMateria.sink.add(await DbCProvider.db.getTodasCalificacionDeMateria(idMateria));
  }



  agregarMateria(MateriaModel materia) async{
     await DbCProvider.db.nuevaMateria(materia);
    obtenerCalificacionesMateria();
  }

  agregarCalificacion(CalificacionModel nuev)async{
    await DbCProvider.db.nuevaCalificacion(nuev);
    obtenerCalificacionesDeMateria(nuev.idMateria);
  }
  eliminarCalificacion(CalificacionModel model)async{
    await DbCProvider.db.eliminarCalificacion(model.id);
    obtenerCalificacionesDeMateria(model.idMateria);
  }


  

  
}