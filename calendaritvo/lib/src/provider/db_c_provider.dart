import 'package:calendaritvo/src/bloc/Materias_bloc.dart';
import 'package:calendaritvo/src/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:io';


class DbCProvider{

  static Database _databse;
  static final DbCProvider db = DbCProvider._();

  DbCProvider._();

  Future<Database> get database async{

    if(_databse!=null){
      return _databse;
    }
    _databse = await initDB();
    return _databse;  
  }
    
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path,"CalificacionesDB.db" );
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (db, version) async{
         await db.execute("Create table Materia (id INTEGER PRIMARY KEY, name TEXT)");
         await db.execute("Create table Calificacion (id INTEGER PRIMARY KEY,idMateria INTEGER, semestre TEXT, calificacion float)");
         
         final  materias =   await DBProvider.db.getTodasMaterias();
         if( materias.length != 0 ){
             print("----------------------------materias--------------------");
           materias.forEach((element) async {
             print(element.name);
             await db.execute("insert into Materia(name) values('${element.name}')");
           });
             print("----------------------------materias--------------------");
         }
      },
    );
  }
  Future<List<MateriaModel>> getTodasCalificaciones()async {
    final db = await database;
    final res = await db.query("Materia");
    List<MateriaModel> list = res.isNotEmpty ? 
                              res.map((item) => MateriaModel.fromJson(item)).
                              toList()
                              : [];
 print("============================gettodaslascalificaciones--------------------");
    list.forEach((element) {
      print(element.name);
    });
    return list;
  }
  nuevaMateria(MateriaModel nuevaM) async{
    final db = await database;
    final res = await db.rawQuery("insert into Materia(name) values('${nuevaM.name}')");
    return res;
  }
}