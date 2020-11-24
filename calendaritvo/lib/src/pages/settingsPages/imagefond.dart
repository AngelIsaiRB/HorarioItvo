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
  final controller =SwiperController();  
      List<String> images=["assets/fondo19.jpg","assets/fondo7.jpg","assets/fondo12.jpg","assets/fondo2.jpg","assets/fondo3.jpg",
                          "assets/fondo4.jpg","assets/fondo5.jpg","assets/fondo6.jpg","assets/fondo1.jpg"
                          ,"assets/fondo8.jpg","assets/fondo11.jpg","assets/fondo10.jpg","assets/fondo13.jpg"
                          ,"assets/fondo14.jpg","assets/fondo15.jpg","assets/fondo16.jpg","assets/fondo17.jpg"
                          ,"assets/fondo18.jpg","assets/fondo9.jpg","assets/fondo20.jpg"];
    
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
              color: Colors.black12,
              child: GestureDetector(
                onTap:_seleccionarFoto,
                child: Container( 
                  padding: EdgeInsets.only(top:10,bottom: 10),           
                  alignment: AlignmentDirectional.topStart,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Desde galería:",style: Theme.of(context).textTheme.headline2,),
                      Container(                    
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("+",style: TextStyle(fontSize: 30),),
                              Icon(Icons.photo, size: 30,)
                            ],
                          ),                      
                        ),
                      )
                    ],
                  )
                  ),
              ),
            ),
            Container(        
              child: Swiper(
                autoplay: true,                
                autoplayDelay: 200,
                autoplayDisableOnInteraction: true,
                controller: controller,           
                itemCount: images.length,
                itemWidth: _screenSize.width *0.7,
                itemHeight: _screenSize.height * 0.8,
                layout: SwiperLayout.STACK,
                onIndexChanged: (e){
                  if(e>1)controller.stopAutoplay();
                },
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
