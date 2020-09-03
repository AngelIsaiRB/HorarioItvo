
import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
 
  
  bool _menu;
  final pref = PreferenciasUsuario();
  int _formIcon;
  bool _progressBar;

  @override
  void initState() { 
    super.initState();
    
    
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
        title: Text("Ajustes", style: Theme.of(context).textTheme.headline2,),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Container(   
       
       child: ListView(
         children: [ 
           _imageF(context),
            Divider(color: Theme.of(context).primaryColor,), 

           Container(
            child: Text("Tema",style: Theme.of(context).textTheme.headline2, ),
          ),                          
          _temaSelector(context),
           Divider(color: Theme.of(context).primaryColor,),
            Container(
            child: Text("Colores",style: Theme.of(context).textTheme.headline2, ),
          ),
          switchColor(),
           
           Divider(color: Theme.of(context).primaryColor,),

           Container(
            child: Text("Medidor de tiempo",style: Theme.of(context).textTheme.headline2, ),
          ), 
            _progressBarSelector(),
           Divider(color: Theme.of(context).primaryColor,),
          Container(
            child: Text("Forma de icono",style: Theme.of(context).textTheme.headline2, ),
          ), 
            _iconForm(),
          
          Divider(color: Theme.of(context).primaryColor,),          
          Text("Menu",style: Theme.of(context).textTheme.headline2,),
          _deleteMenu(),
          Divider(color: Theme.of(context).primaryColor,), 
          Divider(color: Theme.of(context).primaryColor,), 
          Container(
            color: Colors.green[50],
            child: Text("Desarrollador: Angel Isai Ramirez Bazan "
                          "-- qwerasdffdeswa@live.com",style: TextStyle(color: Colors.black, fontSize: 12.0), ),
          ),
          SizedBox(
            height: 20.0,
          )

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
                  color: Colors.pink,//utils.stringToColor(dia.color),
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
                  child: Icon(Icons.fiber_manual_record, color: Colors.pink,size: 45.0, ),
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
              Navigator.pushReplacementNamed(context, "homepage");
            },
          );
  }

Widget switchColor(){
  return Container(
    child: Column(
      children: [
        Text("Colores de la Aplicación"),    
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _colorSelect(888, Colors.black, Colors.white),
          _colorSelect(0,Colors.pink,Colors.pink[50]),
          _colorSelect(1,  Colors.teal, Colors.teal[50]),
          _colorSelect(2, Colors.pink[200], Color.fromRGBO(47, 58, 86, 1))
        ],
        )        
      ],
    ),
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
                     Navigator.pushReplacementNamed(context, "homepage");
                    },
                  )
            );
      },
    ),
  );
}


 Widget _imageF(BuildContext context){
    List<String> images=["assets/fondo7.jpg","assets/fondo2.jpg","assets/fondo3.jpg",
                          "assets/fondo4.jpg","assets/fondo5.jpg","assets/fondo6.jpg","assets/fondo1.jpg"
                          ,"assets/fondo8.jpg"];
    final _screenSize= MediaQuery.of(context).size;
      return Column(
        children: [
          Container(
            alignment: AlignmentDirectional.topStart,
            child: Text("Fondo",style: Theme.of(context).textTheme.headline2,)),
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
                    Navigator.pushReplacementNamed(context, "homepage");
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

    Widget _colorSelect(int value, Color color1, Color color2){
      return GestureDetector(
            onTap: (){
              
              pref.colorApp=value; 
              Navigator.pushReplacementNamed(context, "restart"); 
            },
            child: Container(  
              height: 50.0,
              width: 50.0,          
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              gradient:  LinearGradient(
                 begin: FractionalOffset(0.6,0.0) ,
                 end:   FractionalOffset(0.0,0.2), 
                 colors: [
                  color1,
                  color2,
                ]
                ),

              ),
              
            ),
          );
    }

}