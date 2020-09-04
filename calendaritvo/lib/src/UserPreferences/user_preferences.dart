
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario{

  static PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();
  factory PreferenciasUsuario(){
    return _instancia;
  }
  PreferenciasUsuario._internal();
  SharedPreferences _prefs ;

  initprefs()async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //get set genero

  get tema{
    return _prefs.getInt("tema") ?? 2;
  }

  set tema(int value){
    _prefs.setInt("tema", value);
  }
  
  get colorApp{
    return _prefs.getInt("colorApp") ?? 0;
  }

  set colorApp(int value){
    _prefs.setInt("colorApp", value);
  }

   get imageFond{
    return _prefs.getString("imageFond") ?? "assets/fondo6.jpg";
  }

  set imageFond(String value){
    _prefs.setString("imageFond", value);
  }

   get menu{
    return _prefs.getBool("menu") ?? false;
  }

  set menu(bool value){
    _prefs.setBool("menu", value);
  }

  get formIcon{
    return _prefs.getInt("formIcon") ?? 1;
  }

  set formIcon(int value){
    _prefs.setInt("formIcon", value);
  }

   get progressBar{
    return _prefs.getBool("progressBar") ?? true;
  }

  set progressBar(bool value){
    _prefs.setBool("progressBar", value);
  }

   get formaNoticias{
    return _prefs.getBool("formaNoticias") ?? true;
  }

  set formaNoticias(bool value){
    _prefs.setBool("formaNoticias", value);
  }







}