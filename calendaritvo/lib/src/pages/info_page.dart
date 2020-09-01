import 'dart:math';

import 'package:calendaritvo/src/models/noticias_model.dart';
import 'package:calendaritvo/src/provider/noticias_firebase_provider.dart';
import 'package:calendaritvo/src/widgets/menu_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final noticiasProvider = NoticiasFirebaseProvider();
  
 
  final int pagina=0;
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(      
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [              
              Text("Noticias", style: TextStyle(color: Colors.black, fontSize: 25.0 ), ),
              
            ],
          ),
        ),
        
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: false,
      ),
      drawer: MenuWidget(),
      
      body: _noticias(),

    );
  }

  Widget _noticias() {
    return FutureBuilder(
      future: noticiasProvider.cargarNoticias(),      
      builder: (BuildContext context, AsyncSnapshot<List<Noticia>> snapshot) {
        if(snapshot.hasData){

          final noticias=snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.vertical,            
            itemCount: noticias.length,
            itemBuilder: (BuildContext context, i){
              return _crearTarjeta(noticias[i]);
            }
            );

        } 
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        } 
      },
    );
  }
  Widget _crearTarjeta(Noticia noti){
    final crad=Stack(
          children: [
            Container(
        child: Column(
          children: [                
                FadeInImage(
                image: NetworkImage("${noti.imagen}"),
                placeholder: AssetImage("assets/1.gif"),
                fadeInDuration: Duration(milliseconds: 200),
                height: 300,
                fit: BoxFit.cover,
              ),           
            Container(            
              child: Column(
                children: [
                  Text(noti.texto, style:Theme.of(context).textTheme.subtitle1),
                  SizedBox(height: 20.0,),
                  Container(                
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [   
                        Container(
                          width: 200,
                          child: Text(noti.link,style:TextStyle(color: Colors.black, fontSize: 12.0), overflow: TextOverflow.ellipsis,)),                                    
                        Text(noti.fecha, style:Theme.of(context).textTheme.subtitle1),
                     ], 
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.all(10.0),
            )
          ],
        ),
      ),
      _etiqueta(noti.importancia)
          ]
    );
    final wid= Container(
      margin: EdgeInsets.only(top:25.0, bottom:25.0,left:10.0 ,right: 10.0),     
      child: ClipRRect(
        child: crad,
        borderRadius: BorderRadius.circular(30.0),        
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2,10),
          )
        ]        
      ),
    );

    return GestureDetector(
      child: wid,
      onTap: (){
        abrirLink(noti.link);
      },
    );
  }

  Widget _etiqueta(int imp){
     Color colorImp = Colors.green;
    if(imp==1)colorImp=Colors.red;
    final et= Container(
      child: Transform.rotate(
        angle: -pi/5.0,
        child: Container(
          height: 30,
          width: 150,
          decoration: BoxDecoration(
            color: colorImp
          ),
        ),        
        ),
    );
    return Positioned(
      child: et,
      left: -30.0,
      top: 10.0,
    );
  }

  abrirLink(String link)async{
    if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Could not launch $link';
  }
  }
}