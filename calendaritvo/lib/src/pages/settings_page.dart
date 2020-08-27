
import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
 
  bool _colorSecundario;
  bool _menu;
  final pref = PreferenciasUsuario();
  int _formIcon;
  bool _progressBar;

  @override
  void initState() { 
    super.initState();
    
    _colorSecundario=pref.secundaryColor;
    _menu=pref.menu;
    _formIcon=pref.formIcon;
    _progressBar = pref.progressBar;
  }

  _selectedTema(int value){
    pref.tema=value;    
  }

  _selectFormIcon(int value){
    pref.formIcon=value;
    setState(() {
      _formIcon=value;
    });
  }

  _selectProgressBar(bool value){
    pref.progressBar=value;
    setState(() {
      _progressBar=value;
    });
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
          _temaSelector(context),
           Divider(color: Theme.of(context).primaryColor,),

           Container(
            child: Text("Forma de icono",style: TextStyle(color: Colors.black, fontSize: 40.0), ),
          ), 
            _iconForm(),
           Divider(color: Theme.of(context).primaryColor,),

           Container(
            child: Text("Medidor de tiempo",style: TextStyle(color: Colors.black, fontSize: 40.0), ),
          ), 
            _progressBarSelector(),
           Divider(color: Theme.of(context).primaryColor,),

          Container(
            child: Text("Ambient Color",style: TextStyle(color: Colors.black, fontSize: 40.0), ),
          ),
          switchColor(),
          Divider(color: Theme.of(context).primaryColor,),          
          Text("Menu",style: TextStyle(color: Colors.black, fontSize: 40.0)),
          _deleteMenu(),
          

         ],
       )
    ),
    ); 
  }

  Widget _progressBarSelector(){
    return SwitchListTile(            
            value: _progressBar, 
            title: Text("Activar medidor"),            
            onChanged: (value){
              _selectProgressBar(value);
            },
          );
  }

  Widget _iconForm(){
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                  color: Colors.green,//utils.stringToColor(dia.color),
                  child: SizedBox(width: 45.0,height: 45.0,),
                ),
                Container(                 
                 width: MediaQuery.of(context).size.width *0.5,
                 child: RadioListTile(                         
                        value: 1,
                        title: Text("Cuadrado"),
                        groupValue: _formIcon,
                         onChanged: (value){
                           _selectFormIcon(value);
                         },
                     ),
                    ),
            ],
          ),
          Column(
            children: [
              Container(
                  //utils.stringToColor(dia.color),
                  child: Icon(Icons.fiber_manual_record, color: Colors.green,size: 45.0, ),
                ),
                Container(                 
                 width: MediaQuery.of(context).size.width *0.5,
                 child: RadioListTile(                         
                        value: 2,
                        title: Text("Circular"),
                        groupValue: _formIcon,
                         onChanged: (value){
                           _selectFormIcon(value);
                         },
                     ),
                    ),
            ],
          ),
        ],
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

Widget switchColor(){
  return SwitchListTile(
            inactiveTrackColor: Colors.pink,
            activeColor: Colors.teal,
            value: _colorSecundario, 
            title: Text("Color secundario"),
            subtitle: Text("Reinicia para ver cambios"),
            onChanged: (value){
              setState(() {
              _colorSecundario=value;
              pref.secundaryColor=value;                        
              });
            },
          );
}

Widget _temaSelector(BuildContext context){
  List<String> temas=["assets/tema1.jpg","assets/tema2.jpg","assets/tema3.jpg"];
  List<String> temanames=["Rigel","Betelgeuse","Antares"];
  final _screenSize= MediaQuery.of(context).size;
  return Container(
    child: Swiper(
      itemCount: temas.length,
      itemWidth: _screenSize.width *0.6,
      itemHeight: _screenSize.height * 0.6,
      layout: SwiperLayout.STACK,
      itemBuilder: (BuildContext context, int index){
                return Container(
                  color: Theme.of(context).canvasColor, 
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: GestureDetector(
                    child: Column(                      
                      children: [
                        Container(                                        
                          child: Image(image: AssetImage(temas[index]), )
                          ),
                          Text(temanames[index],style: TextStyle(color: Colors.black, fontSize: 30.0),)
                      ],
                    ),
                    onTap: (){
                      _selectedTema(index+1);
                      Navigator.pushNamed(context, "homepage");
                    },
                  )
            );
      },
    ),
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