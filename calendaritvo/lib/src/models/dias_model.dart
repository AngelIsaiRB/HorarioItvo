class DiaModel{

  int id;
  String materia;
  String color;

   DiaModel({
    this.id,
    this.materia,
    this.color,
    
  });


  factory DiaModel.fromJson(Map<String, dynamic> json)=>DiaModel(
    id:json["id"],
    materia:json["materia"],
    color:json["color"],
  );

  Map<String,dynamic> toJson()=>{
    "id":id,
    "materia":materia,
    "color":color,
  };

}