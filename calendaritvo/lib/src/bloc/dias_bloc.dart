import 'dart:async';


import 'package:calendaritvo/src/models/dias_model.dart';
import 'package:calendaritvo/src/provider/db_provider.dart';

class DiaBloc{


  static final DiaBloc _singleton = new DiaBloc._internal();

  DiaBloc._internal(){
  obtenerDia("Lunes");
  }
  factory DiaBloc(){
    return _singleton;
  }

  final _diaController = StreamController<List<DiaModel>>.broadcast();

  Stream<List<DiaModel>> get diaStream => _diaController.stream;

  dispose(){
    _diaController?.close();
  }

  obtenerDia(String dia) async{
    _diaController.sink.add(await DBProvider.db.getDia(dia));
  }

  

 

  
}