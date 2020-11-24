import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TemaSelector extends StatefulWidget {
  @override
  _TemaSelectorState createState() => _TemaSelectorState();
}

class _TemaSelectorState extends State<TemaSelector> {
  final controller = SwiperController();

  final pref = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temas", style: Theme.of(context).textTheme.headline2,),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
      ),
      body: _temaSelector(context),
    );
          
  }
  Widget _temaSelector(BuildContext context){
  List<String> temas=["assets/tema1.jpg","assets/tema2.jpg","assets/tema3.jpg"];
  List<String> temanames=["Rigel","Betelgeuse","Antares"];
  final _screenSize= MediaQuery.of(context).size;
  return Column(
    children: [
      
      Container(     
        padding: EdgeInsets.only(top:10),   
        child: Swiper(
          autoplay: true,
          autoplayDelay: 200,
          autoplayDisableOnInteraction: true,
          controller: controller,
          onIndexChanged: (e){
            if(e>1){
              controller.stopAutoplay();
            }
          },
          itemCount: temas.length,
          itemWidth: _screenSize.width *0.8,
          itemHeight: _screenSize.height * 0.7,
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
  _selectedTema(int value){
    pref.tema=value;    
  }
}