import 'dart:io';

import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:image_picker/image_picker.dart';

class ImageFonda extends StatefulWidget {
  @override
  _ImageFondaState createState() => _ImageFondaState();
}

class _ImageFondaState extends State<ImageFonda> {
  final pref = PreferenciasUsuario();
      List<String> images=["assets/fondo7.jpg","assets/fondo9.jpg","assets/fondo10.jpg","assets/fondo2.jpg","assets/fondo3.jpg",
                          "assets/fondo4.jpg","assets/fondo5.jpg","assets/fondo6.jpg","assets/fondo1.jpg"
                          ,"assets/fondo8.jpg","assets/fondo11.jpg","assets/fondo12.jpg","assets/fondo13.jpg"
                          ,"assets/fondo14.jpg","assets/fondo15.jpg","assets/fondo16.jpg","assets/fondo17.jpg"
                          ,"assets/fondo18.jpg","assets/fondo19.jpg"];
    
  @override
  Widget build(BuildContext context) {
    final _screenSize= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Imagen", style: Theme.of(context).textTheme.headline2,),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
      ),
      body: Container(
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
      ) ,
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
