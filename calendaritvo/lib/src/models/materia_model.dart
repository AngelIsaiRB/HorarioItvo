class MateriaModel{

  int id;
  String name;
  String color;


  MateriaModel({
    this.id,
    this.name,
    this.color
  });


  factory MateriaModel.fromJson(Map<String, dynamic> json)=>MateriaModel(
    id:json["id"],
    name:json["name"],
    color:json["color"]
  );

  Map<String,dynamic> toJson()=>{
    "id":id,
    "name":name,
    "color": color
  };






}