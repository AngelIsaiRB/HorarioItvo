
import 'dart:convert';

import 'package:calendaritvo/src/models/calendario_model.dart';
import 'package:http/http.dart' as http;

class CalendarioFirebaseProvider{


  final String _url="https://itvo-6103d.firebaseio.com";

 Future<List<Calendario>>cargarCalendario() async {
   final url="$_url/calendario.json";
   final response =await http.get(url);
   final Map<String, dynamic> decodeData= json.decode(response.body);
   final List<Calendario> notis = new List();
   if (decodeData==null){
     return [];
   }
   decodeData.forEach((key, value) {
    final temp = Calendario.fromJson(value);    
    notis.add(temp);
  });
  return notis;
 }

}