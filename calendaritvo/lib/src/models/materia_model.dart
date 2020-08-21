class MateriaModel{

  int id;
  String name;


  MateriaModel({
    this.id,
    this.name
  });


  factory MateriaModel.fromJson(Map<String, dynamic> json)=>MateriaModel(
    id:json["id"],
     name:json["name"],
  );

  Map<String,dynamic> toJson()=>{
    "id":id,
    "name":name
  };






}