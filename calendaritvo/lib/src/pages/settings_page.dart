
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
            SizedBox(height: 20.0,), 

           Container(
            child: Text("Tema",style: Theme.of(context).textTheme.headline2, ),
          ),
          _temaSelector(context),
           SizedBox(height: 20.0,),
            Container(
            child: Text("Colores",style: Theme.of(context).textTheme.headline2, ),
          ),
          switchColor(),
           
           SizedBox(height: 20.0,),

           Container(
            child: Text("icono/tarjeta",style: Theme.of(context).textTheme.headline2, ),
          ), 
            _iconForm(),
           SizedBox(height: 20.0,),
            Container(
            child: Text("Medidor de tiempo",style: Theme.of(context).textTheme.headline2, ),
          ), 
            _progressBarSelector(),
          
          
          SizedBox(height: 20.0,),          
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left:15.0 ),
                color: Color.fromRGBO(48, 48, 48, 1.0),
                child: Icon(Icons.warning,size: 50.0, color: Colors.yellow,)),
              Text("Menu",style: Theme.of(context).textTheme.headline2,),
            ],
          ),
          _deleteMenu(),          
          SizedBox(
            height: 20.0,
          ),
          Text("Version 1.4.0    "
               "Esta version no guarda tu horario en la nube "
               "¡ten cuidado al limpiar el caché o datos de la App!",style: Theme.of(context).textTheme.subtitle1 
               ),
        
          SizedBox(height: 20.0,), 
          Container(
            color: Colors.green[50],
            child: Text("Desarrollador: Angel Isai Ramirez Bazan "
                          "-- qwerasdffdeswa@live.com",style: TextStyle(color: Colors.black, fontSize: 12.0), ),
          ),


         ],
       )
    ),
    ); 
  }

  Widget _progressBarSelector(){
    return SwitchListTile(     
            activeColor: Theme.of(context).primaryColor,       
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
                   activeColor: Theme.of(context).primaryColor,                         
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
                        activeColor: Theme.of(context).primaryColor,  
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
    return Container(
     
      child: SwitchListTile(            
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
            ),
    );
  }

Widget switchColor(){
  return Container(
    child: Column(
      children: [
        Text("Colores de la Aplicación", style: Theme.of(context).textTheme.bodyText1),   
        SizedBox(height: 10.0,), 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _colorSelect(888, Colors.black, Colors.white),
          _colorSelect(0,Colors.pink,Colors.pink[50]),
          _colorSelect(1,  Colors.teal, Colors.teal[50]),
         _colorSelect(8,Colors.blue, Colors.blue[50]),
          _colorSelect(4, Colors.purple[50], Colors.yellow),          
        ],
        ),        
         SizedBox(height: 8.0,), 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
         _colorSelect(3, Color.fromRGBO(255, 218, 125, 1), Colors.purple),
           _colorSelect(2, Colors.pink[200], Color.fromRGBO(47, 58, 86, 1)),
          _colorSelect(5, Color.fromRGBO( 234, 95, 64, 1), Color.fromRGBO( 31, 78, 90, 1)),
          _colorSelect(6, Color.fromRGBO( 230, 242, 238, 1), Color.fromRGBO( 20, 102, 75, 1)),
           _colorSelect(7, Color.fromRGBO( 118, 96, 146, 1), Color.fromRGBO( 231, 211, 238, 1))
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
                  child: GestureDetector(
                    child: Column(                      
                      children: [                                                             
                          Image(image: AssetImage(temas[index]), ),                         
                          Text(temanames[index],style: Theme.of(context).textTheme.headline3,)
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
    List<String> images=["assets/fondo7.jpg","assets/fondo9.jpg","assets/fondo10.jpg","assets/fondo2.jpg","assets/fondo3.jpg",
                          "assets/fondo4.jpg","assets/fondo5.jpg","assets/fondo6.jpg","assets/fondo1.jpg"
                          ,"assets/fondo8.jpg","assets/fondo11.jpg","assets/fondo12.jpg","assets/fondo13.jpg"
                          ,"assets/fondo14.jpg","assets/fondo15.jpg","assets/fondo16.jpg","assets/fondo17.jpg"
                          ,"assets/fondo18.jpg","assets/fondo19.jpg"];
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
      return Container(
        
        child: GestureDetector(
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
                      Navigator.pushReplacementNamed(context, "restart");
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
        ),
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