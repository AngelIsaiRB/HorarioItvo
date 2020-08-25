
import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _tema;
  bool _colorSecundario;
  bool _menu;
  final pref = PreferenciasUsuario();

  @override
  void initState() { 
    super.initState();
    _tema=pref.tema;
    _colorSecundario=pref.secundaryColor;
    _menu=pref.menu;
  }

  _selectedTema(int value){
    pref.tema=value;
    _tema=value;setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes", style: TextStyle(fontSize: 50.0, color: Colors.black),),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Container(        
       child: ListView(
         children: [ 
           _imageF(context),
            Divider(color: Theme.of(context).primaryColor,),     
           Container(
            child: Text("Tema",style: TextStyle(color: Colors.black, fontSize: 40.0), ),
          ),               
           Container(            
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width *0.4,
                  height: MediaQuery.of(context).size.width * 0.7,
                  child: Image(image: AssetImage("assets/tema1.jpg"), )),
                Container(
                  width: MediaQuery.of(context).size.width *0.4,
                  height: MediaQuery.of(context).size.width * 0.7,
                  child: Image(image: AssetImage("assets/tema2.jpg"),  )), 
              ],
          ),
           ),
           Container(           
            child:Row(
             children: [
               Container(                 
                 width: MediaQuery.of(context).size.width *0.5,
                 child: RadioListTile(                         
                        value: 1,
                        title: Text("Rigel"),
                        groupValue: _tema,
                         onChanged: (value){
                           _selectedTema(value);
                         },
                     ),
               ),
               Container(                 
                 width: MediaQuery.of(context).size.width *0.5,
                 child: RadioListTile(  
                   activeColor: Theme.of(context).primaryColor,                       
                        value: 2,
                        title: Text("Betelgeuse"),
                        groupValue: _tema,
                         onChanged: (value){
                           _selectedTema(value);
                         },
                     ),
               ),
             ], 
            )
          ),
           Divider(color: Theme.of(context).primaryColor,),
           
          Container(
            child: Text("Color",style: TextStyle(color: Colors.black, fontSize: 40.0), ),
          ),
          SwitchListTile(
            inactiveTrackColor: Colors.pink,
            activeColor: Colors.teal,
            value: _colorSecundario, 
            title: Text("Color secundario"),
            onChanged: (value){
              setState(() {
              _colorSecundario=value;
              pref.secundaryColor=value;                        
              });
            },
          ),
          Divider(color: Theme.of(context).primaryColor,),          
          Text("Menu",style: TextStyle(color: Colors.black, fontSize: 40.0)),
          _deleteMenu(),
          

         ],
       )
    ),
    ); 
  }

  Widget _deleteMenu(){
    return SwitchListTile(            
            value: _menu, 
            title: Text("Quitar Noticias"),
            subtitle: Text("Si no eres parte del ITVO o no te interesan las noticias"),
            onChanged: (value){
              setState(() {
                  _menu=value;
                  pref.menu=value;           
              });
              Navigator.pushNamed(context, "homepage");
            },
          );
  }


 Widget _imageF(BuildContext context){
    List<String> images=["assets/fondo1.jpg","assets/fondo2.jpg","assets/fondo3.jpg",
                          "assets/fondo4.jpg","assets/fondo5.jpg","assets/fondo6.jpg","assets/fondo7.jpg"
                          ,"assets/fondo8.jpg"];
    final _screenSize= MediaQuery.of(context).size;
      return Column(
        children: [
          Container(
            alignment: AlignmentDirectional.topStart,
            child: Text("Fondo",style: TextStyle(color: Colors.black, fontSize: 40.0))),
          Container(        
            child: Swiper(
              itemCount: images.length,
              itemWidth: _screenSize.width *0.5,
              itemHeight: _screenSize.height * 0.5,
              layout: SwiperLayout.STACK,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: image(index,images));
              },
            ),
          ),
        ],
      );      
    }

    Widget image(int index, List<String> images ){
      return GestureDetector(
        child: Image(image: AssetImage(images[index])),
        onTap: (){
          showDialog(
           context: context,
           barrierDismissible: true,
           builder: (context){
               return  AlertDialog(
                 title: Text("¿Establecer como fondo?"),
                 actions: [
                   FlatButton(
                     child: Text("Si"),
                     onPressed: (){
                     pref.imageFond=images[index];
                     Navigator.pushNamed(context, "homepage");
                     },
                   ),
                   FlatButton(
                     child: Text("No"),
                     onPressed: (){
                       Navigator.pop(context);
                     },
                   ),
                 ],
               );
           });
        },
      );
    }

}