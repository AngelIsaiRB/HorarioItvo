class DiaModel{

  int id;
  String materia;

   DiaModel({
    this.id,
    this.materia,
    
  });


  factory DiaModel.fromJson(Map<String, dynamic> json)=>DiaModel(
    id:json["id"],
    materia:json["materia"],
    
  );

  Map<String,dynamic> toJson()=>{
    "id":id,
    "materia":materia,
    
  };

}