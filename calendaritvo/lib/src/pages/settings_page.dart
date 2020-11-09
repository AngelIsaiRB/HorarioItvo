
import 'dart:io';

import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:calendaritvo/src/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:url_launcher/url_launcher.dart';

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
            Container(color: Theme.of(context).cardColor, child: _imageF(context)),                        
            _temaSelector(context),                   
            Container( color: Theme.of(context).cardColor,child: switchColor()),                                 
            _iconForm(),                      
            Container( color: Theme.of(context).cardColor,child: _progressBarSelector()),   
             _notificaciones(),                                                  
          Container( color: Theme.of(context).cardColor,child: _deleteMenu()),   
             
         
          SizedBox(
            height: 20.0,
          ),          
          _restaurar(),     
          Container(
             color: Theme.of(context).cardColor,
            margin: EdgeInsets.all(10.0),
            child: Text("Version 1.5.1   ⛔"
                 "Esta version no guarda tu horario en la nube "
                 "¡ten cuidado al limpiar el caché o datos de la App!",style: Theme.of(context).textTheme.subtitle1 
                 ),
          ),
          SizedBox(height: 20.0,), 
          datoDeDesarollador(),


         ],
       )
    ),
    ); 
  }

  Widget _progressBarSelector(){
    return Column(
      children: [
        Container(            
            alignment: AlignmentDirectional.topStart,
            child: Text("Medidor de tiempo",style: Theme.of(context).textTheme.headline2,)),
        SwitchListTile(     
                activeColor: Theme.of(context).primaryColor,       
                value: _progressBar, 
                title: Text("Activar medidor"),            
                onChanged: (value){
                  _selectProgressBar(value);
                },
              ),
      ],
    );
  }

  Widget _iconForm(){
    return Column(
      children: [
        Container(            
            alignment: AlignmentDirectional.topStart,
            child: Text("Icono / tarjeta",style: Theme.of(context).textTheme.headline2,)),
        Container(
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
        ),
      ],
    );
  }

  Widget _deleteMenu(){
    return Column(
      children: [
        Row(
            children: [
              Container(
                margin: EdgeInsets.only(left:15.0 ),
                color: Color.fromRGBO(48, 48, 48, 1.0),
                child: Icon(Icons.warning,size: 50.0, color: Colors.yellow,)),
              Text("Menu",style: Theme.of(context).textTheme.headline2,),
            ],
          ),
        Container(
         
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
        ),
      ],
    );
  }

Widget switchColor(){
  return Container(
    margin: EdgeInsets.all(5),
    child: Column(
      children: [
        Container(            
              alignment: AlignmentDirectional.topStart,
              child: Text("Colores",style: Theme.of(context).textTheme.headline2,)),
        Container(
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
        ),
      ],
    ),
  );
}

Widget _temaSelector(BuildContext context){
  List<String> temas=["assets/tema1.jpg","assets/tema2.jpg","assets/tema3.jpg"];
  List<String> temanames=["Rigel","Betelgeuse","Antares"];
  final _screenSize= MediaQuery.of(context).size;
  return Column(
    children: [
      Container(            
            alignment: AlignmentDirectional.topStart,
            child: Text("Tema",style: Theme.of(context).textTheme.headline2,)),
      Container(        
        child: Swiper(
          itemCount: temas.length,
          itemWidth: _screenSize.width *0.6,
          itemHeight: _screenSize.height * 0.63,
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
      ),
    ],
  );
}


 Widget _imageF(BuildContext context){
    List<String> images=["assets/fondo7.jpg","assets/fondo9.jpg","assets/fondo10.jpg","assets/fondo2.jpg","assets/fondo3.jpg",
                          "assets/fondo4.jpg","assets/fondo5.jpg","assets/fondo6.jpg","assets/fondo1.jpg"
                          ,"assets/fondo8.jpg","assets/fondo11.jpg","assets/fondo12.jpg","assets/fondo13.jpg"
                          ,"assets/fondo14.jpg","assets/fondo15.jpg","assets/fondo16.jpg","assets/fondo17.jpg"
                          ,"assets/fondo18.jpg","assets/fondo19.jpg"];
    final _screenSize= MediaQuery.of(context).size;
      return Container(
         margin: EdgeInsets.all(5),
        child: Column(        
          children: [
            Container(            
              alignment: AlignmentDirectional.topStart,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Fondo",style: Theme.of(context).textTheme.headline2,),
                  Container(                    
                    child: GestureDetector(
                      child: Row(
                        children: [
                          Text("Agregar"),
                          Icon(Icons.photo, size: 30,)
                        ],
                      ),
                      onTap:_seleccionarFoto,
                    ),
                  )
                ],
              )
              ),
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
        ),
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
                         pref.ispathImage=false;
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
                   color1,color2
                 ]
                ),

              ),
              
            ),
          );
    }
    _restaurar(){
      return Container(
        margin: EdgeInsets.only(left: 50,right:50 ),
        color: Colors.red,
        child: FlatButton(
          onPressed: (){
            final snackBar = SnackBar(content: Text('Manten presionado'),
            duration: Duration(milliseconds: 1000),);
           Scaffold.of(context).showSnackBar(snackBar);

          },
          onLongPress: (){
            showDialog(
             context: context,
             barrierDismissible: true,
             builder: (context){
                 return  AlertDialog(
                   title: Text("¿Eliminar Materias, horario y restablecer?"),
                   actions: [
                     FlatButton(
                       child: Container(
                         color: Colors.redAccent,
                         padding: EdgeInsets.all(15),
                         child: Text("Si")),
                       onPressed: (){
                       DBProvider.db.eliminarDB();                       
                       Navigator.pop(context);
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.warning),
              Text("Restablecer Horario",style: TextStyle(fontSize: 20),),
            ],
          ),
        ),
      );
    }

  Widget datoDeDesarollador() {
    return Container(
      margin: EdgeInsets.only(left: 50,right: 50),
      height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueAccent
            ),
            child: FlatButton(              
              onPressed: (){
                abrirLink("https://angelisairamirezbazan.netlify.app");
              },
              child: Row(
                children: [
                  Icon(Icons.language),
                  Text("Developer: Angel Isai Ramirez Bazan "),
                ],
              ),
            ),
          );
  }
abrirLink(String link)async{
    if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Could not launch $link';
  }
  }

  Widget _notificaciones() {
    return Container(
      margin: EdgeInsets.only(left: 5,right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Desactivar notificaciones"),
          FlatButton(
            color: Colors.blueAccent,
            child: Icon(Icons.alarm_off),
            onPressed: (){
              showDialog(
      context: context,
      builder: (BuildContext context){
          return AlertDialog(
            title: Text("Descativar notificaciones"),
            content: Text("""Desafortunadamente en esta versión tendrás que hacerlo manualmente:

1- Entra en ajustes de la aplicación (puedes hacerlo presionando por unos segundos el icono de la app).

2- En el apartado notificaciones selecciona 'Desactivar'."""),
          );
      }
  );
            },
          ),
        ],
      ),
    );
  }

  _seleccionarFoto()async {
    final piker = ImagePicker();
    final file = await piker.getImage(source: ImageSource.gallery);
    if(file!=null){
      final foto = File(file.path);
    pref.ispathImage=true;
    pref.imageFond=foto.path;
    Navigator.pushReplacementNamed(context, "restart");
    }

  }
}