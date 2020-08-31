
import 'dart:convert';

import 'package:calendaritvo/src/models/noticias_model.dart';
import 'package:http/http.dart' as http;

class NoticiasFirebaseProvider{


  final String _url="https://itvo-6103d.firebaseio.com/";

 Future<List<Noticia>>cargarNoticias() async {
   final url="$_url/noticias.json";
   final response =await http.get(url);
   final Map<String, dynamic> decodeData= json.decode(response.body);
   final List<Noticia> notis = new List();
   if (decodeData==null){
     return [];
   }
   decodeData.forEach((key, value) {
    final temp = Noticia.fromJson(value);
    temp.id=key;  
    notis.add(temp);
  });
  return notis;
 }

}