
import 'package:calendaritvo/src/models/calificacion_model.dart';
import 'package:calendaritvo/src/provider/db_provider.dart';

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
         await db.execute("Create table Materia (id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT)");
         await db.execute("Create table Calificacion (id INTEGER PRIMARY KEY AUTOINCREMENT ,idMateria INTEGER, semestre TEXT, calificacion float)");
         
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
  Future<List<MateriaModel>> getTodasCalificacionesMaterias()async {
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

  Future<List<CalificacionModel>> getTodasCalificacionDeMateria(int idMateria)async{

    final db= await database;
    final res = await db.rawQuery("SELECT * FROM Calificacion WHERE idMateria=$idMateria");
    List<CalificacionModel> list = res.isNotEmpty ? 
                              res.map((item) => CalificacionModel.fromJson(item)).
                              toList()
                              : [];
    return list;                              

  }
  
  nuevaMateria(MateriaModel nuevaM) async{
    final db = await database;
    final res = await db.rawQuery("insert into Materia(name) values('${nuevaM.name}')");
    return res;
  }

  nuevaCalificacion(CalificacionModel nuev) async{
    final db= await database;
    final res= await db.insert("Calificacion", nuev.toJson());   
    return res;
  }
  actualizarCalificacion(CalificacionModel model)async {
    final db = await database;
    final res = await db.rawUpdate("Update Calificacion SET calificacion=${model.calificacion} WHERE id=${model.id}");
    return res;
  }

  eliminarCalificacion(int id) async{
    final db= await database;
    final res = await db.delete("Calificacion", where: "id=?", whereArgs: [id] );  
    return res;
  }
  eliminarMateria(String name)async{
    final db= await database;
    final res = await db.delete("Materia", where: "name=?", whereArgs: [name] );  
    return res;
  }
  eliminarTodasCalificacionesDeMateria(MateriaModel model)async{
    final db= await database;
    final res = await db.delete("Calificacion", where: "idMateria=?", whereArgs: [model.id]);  
    return res;
  }


  Future<double>promedioCalificacion( int id)async{
    final mate = await getTodasCalificacionDeMateria(id);
    double promedio=0;        
         if(mate.length>=1){
           mate.forEach((element) {
           promedio = promedio + element.calificacion;
        });
        promedio=promedio/mate.length;
         }
    return promedio;     
  }
  ///!! are you sure????
eliminarDB()async{
    final db= await database;    
    
    await deleteDatabase(db.path);
    _databse=await initDB();
  }
}