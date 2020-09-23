class DiaModel{

  int id;
  String materia;
  String color;
  String range;

   DiaModel({
    this.id,
    this.materia,
    this.color,
    this.range,
  });


  factory DiaModel.fromJson(Map<String, dynamic> json)=>DiaModel(
    id:json["id"],
    materia:json["materia"],
    color:json["color"],
    range: json["range"],
  );

  Map<String,dynamic> toJson()=>{
    "id":id,
    "materia":materia,
    "color":color,
    "range":range,
  };

}