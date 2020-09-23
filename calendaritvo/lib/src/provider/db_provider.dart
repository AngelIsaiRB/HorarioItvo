
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
    
    if(_dataBase!=null){    
     
    return _dataBase;
    }
    
    _dataBase= await initDB();
    return _dataBase;  
  }
  initDB() async{
 
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path,"HorarioDB.db" );
    
    return await openDatabase(
      path,
      version: 2,
      onOpen: (db){},
      onCreate: (Database db, int version) async {       
      await db.execute("Create table Materia   (id INTEGER PRIMARY KEY, name TEXT, color TEXT)") ;        
      await db.execute("Create table Lunes     (id INTEGER PRIMARY KEY, materia TEXT, horas int)");  
      await db.execute("Create table Martes    (id INTEGER PRIMARY KEY, materia TEXT, horas int)");
      await db.execute("Create table Miercoles (id INTEGER PRIMARY KEY, materia TEXT, horas int)");
      await db.execute("Create table Jueves    (id INTEGER PRIMARY KEY, materia TEXT, horas int)");
      await db.execute("Create table Viernes   (id INTEGER PRIMARY KEY, materia TEXT, horas int)");
      await db.execute("Create table Sabado    (id INTEGER PRIMARY KEY, materia TEXT, horas int)");          
      await db.execute("INSERT into Materia(name,color) values('Libre','white')");   

     // await db.execute("Create table DiasHoras (id INTEGER PRIMARY KEY, name TEXT, horas int)"); 
      //await _rellenarDiasHoras(db);      

      await _rellenarDia(db);     
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        print ("---------------Actualizo DB : $newVersion ---------");
         await db.execute("Create table DiasHoras (id INTEGER PRIMARY KEY, name TEXT, horas int)"); 
         await _rellenarDiasHoras(db);
          print ("---------------Fin de Actualizacion DB : $newVersion ---------");
      },
      
    );
  }

  _rellenarDiasHoras(db) async{    
    print("Crea Tabla DiasHoras-*****************");
    List<String> _nombredias =["Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","D"];    
    for (var i = 0; i < _nombredias.length; i++) {
      await db.execute("insert into DiasHoras (name,horas) values('${_nombredias[i]}',1)");
    }
  }

  _rellenarDia(db)async {
    List<String> _nombredias =["Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","D"];    
    for (var j = 0; j < 6; j++) {
      for (var i = 0; i < 12; i++) {
      await db.execute("INSERT into ${_nombredias[j]} (materia) values('Libre')");

    }
    }
  }
  
  Future<List<int>> getHorasDias()async{
      final db= await database;
      final res= await db.query("DiasHoras");
      List<int> horas=[];
      res.forEach((element) => horas.add(element["horas"]));
      print(horas);
      return horas;

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

  Future<int> deleteMateria(MateriaModel materia)async {
    final db = await database;
    final res = await db.delete("Materia", where: "id=?", whereArgs: [materia.id] );  
    List<String> _nombredias =["Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","D"]; 
    for (var i = 0; i < 6; i++) {
     await db.rawUpdate("Update ${_nombredias[i]} SET materia='Libre' WHERE materia='${materia.name}'");
      
    }
    return res;
  }



  Future<List<DiaModel>> getDia(String dia) async{
    final db = await database;
    final res = await db.rawQuery("SELECT $dia.id , $dia.materia , Materia.color from $dia , Materia WHERE $dia.materia=Materia.name ");
    List<DiaModel> list = res.isNotEmpty ? 
                              res.map((item) => DiaModel.fromJson(item)).
                              toList()
                              : [];
    return list;
  }
  
  actualizarHora(int id,String materia,String day)async {
    final db = await database;
    final res = await db.rawUpdate("Update $day SET materia='$materia' WHERE id=$id");
    return res;
  }
  agregarNumeroDeHoras(String day, int number)async {
    final db = await database;
    number++;
    final res= await db.rawUpdate("Update DiasHoras set horas=$number where name='$day' ");
    print(res);
  }
  restarNumeroDeHoras(String day, int number)async {
    final db = await database;
    number--;
    final res= await db.rawUpdate("Update DiasHoras set horas=$number where name='$day' ");
    print(res);
  }



}