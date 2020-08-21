
import 'dart:io';

import 'package:calendaritvo/src/models/dias_model.dart';
import 'package:calendaritvo/src/models/materia_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
export 'package:calendaritvo/src/models/materia_model.dart';

class DBProvider{

  static Database _dataBase;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if(_dataBase!=null)
    return _dataBase;
    
    _dataBase= await initDB();
    return _dataBase;  
  }
  initDB() async{

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path,"HorarioDB.db" );

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {
      await db.execute(
          "Create table Materia (id INTEGER PRIMARY KEY, name TEXT, color TEXT)"
      ) ;      
      await db.execute(
          "Create table Lunes (id INTEGER PRIMARY KEY, materia INT)"
      );  
      await db.execute(
          "INSERT into Materia(name,color) values('Libre','white')"
      );     
      _rellenarDia(); 

      }
    );
  }

  _rellenarDia()async {
    final db = await database;
    for (var i = 0; i < 12; i++) {
      await db.execute("INSERT into Lunes(materia) values('Libre')");
    }
  }

  nuevaMateria(MateriaModel nuevaM) async{
    final db = await database;
    final res = await db.insert("Materia", nuevaM.toJson());
    return res;
  }

  Future<List<MateriaModel>> getTodasMaterias()async {
    final db = await database;
    final res = await db.query("Materia");
    List<MateriaModel> list = res.isNotEmpty ? 
                              res.map((item) => MateriaModel.fromJson(item)).
                              toList()
                              : [];
    return list;
  }

  Future<int> deleteMateria(int id)async {
    final db = await database;
    final res = await db.delete("Materia", where: "id=?", whereArgs: [id] );
    return res;
  }

  Future<List<DiaModel>> getLunes() async{
    final db = await database;
    final res = await db.query("Lunes");
    List<DiaModel> list = res.isNotEmpty ? 
                              res.map((item) => DiaModel.fromJson(item)).
                              toList()
                              : [];
    return list;
  }
  



}