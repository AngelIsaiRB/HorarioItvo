
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

  get secundaryColor{
    return _prefs.getBool("secundaryColor") ?? false;
  }

  set secundaryColor(bool value){
    _prefs.setBool("secundaryColor", value);
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
  







}