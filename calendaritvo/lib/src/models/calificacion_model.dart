
import 'dart:ffi';

class CalificacionModel{

  final int    id;
  final int    idMateria;
  final String semestre;
  final double  calificacion;

  CalificacionModel({
    this.id, 
    this.idMateria, 
    this.semestre, 
    this.calificacion
});

factory CalificacionModel.fromJson(Map<String, dynamic> json)=>CalificacionModel(
  id :json["id"],
  idMateria :json["idMateria"],
  semestre :json["semestre"],
  calificacion : json["calificacion"],
  );

  Map<String,dynamic> toJson()=>{
    "id":id,
    "idMateria":idMateria,
    "semestre": semestre,
    "calificacion":calificacion,
    
    };


}