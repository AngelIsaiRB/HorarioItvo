import 'dart:convert';

  Calendario calendarioFromJson(String str)=> Calendario.fromJson(json.decode(str));

  String calendarioToJson(Calendario data) => json.encode(data.toJson());


class Calendario{
  Calendario({
    this.link,
    this.mes,
    this.year,
  });


  String link;
  String mes;
  int year;

  factory Calendario.fromJson(Map<String,dynamic> json)=>Calendario(
    link : json["link"],
    mes  : json["mes"],
    year : json["year"]
  );

  Map<String, dynamic> toJson()=>{
    "link" :link,
    "mes"  :mes,
    "year" :year,
  };

}