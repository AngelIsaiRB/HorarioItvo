import 'dart:math';

import 'package:calendaritvo/src/UserPreferences/user_preferences.dart';
import 'package:calendaritvo/src/helpers/helpers.dart' as helper;
import 'package:calendaritvo/src/models/noticias_model.dart';
import 'package:calendaritvo/src/provider/noticias_firebase_provider.dart';
import 'package:calendaritvo/src/widgets/menu_widget.dart';

import 'package:flutter/material.dart';
class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final noticiasProvider = NoticiasFirebaseProvider();
  final pref= PreferenciasUsuario();
  int vista=0;
  bool _modoVista;
  void initState() { 
    super.initState();
    _modoVista=pref.formaNoticias;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(        
       key: _scaffoldKey,
      appBar: AppBar(  
        leading: Container(),                     
        title: Container(
          padding: EdgeInsets.only(top: 10.0),          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [              
              Text("I T V O",  style: Theme.of(context).textTheme.headline3, ),                            
            ],

          ),
        ),        
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: false,
        actions: [
          FlatButton(
            child:  _modoVista?Icon(Icons.view_list):Icon(Icons.call_to_action),
            onPressed: (){
              setState(() {
                _modoVista==true? _modoVista=false:_modoVista=true;
                pref.formaNoticias=_modoVista;
              });
            },
          ),
          _changeImport(),
        ],
      ),
       drawer: MenuWidget(),            
      body: Stack(
        children: [
          helper.imagenFondo(),
          AnimatedContainer(
            child: _noticias(),
           duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutBack,
            ),
        ],
      ),
      floatingActionButton: _floatingB(),
      
    );
  }

  Widget _noticias() {
    return FutureBuilder(
      future: noticiasProvider.cargarNoticias(),      
      builder: (BuildContext context, AsyncSnapshot<List<Noticia>> snapshot) {
        if(snapshot.hasData){
          final noticias=snapshot.data;          
          return  RefreshIndicator(
            onRefresh: (){            
            setState(() {
            });
            return  noticiasProvider.cargarNoticias();
            },
              child: ListView.builder(
              scrollDirection: Axis.vertical,            
              itemCount: noticias.length,
              itemBuilder: (BuildContext context, i){
                if(vista==1 && noticias[i].importancia==1){
                //return _crearTarjeta2(noticias[i]);
                return _modoVista?_crearTarjeta(noticias[i]):_crearTarjeta2(noticias[i]);
                }
                if(vista==0)
                return _modoVista?_crearTarjeta(noticias[i]):_crearTarjeta2(noticias[i]);
                else
                return Container();
              }
              ),
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
              color: Theme.of(context).cardColor,                          
            child: Column(
            children: [                
                Container(                                   
                  child: FadeInImage(
                  image: NetworkImage("${noti.imagen}"),
                  placeholder: AssetImage("assets/1.gif"),
                  fadeInDuration: Duration(milliseconds: 200),
                  height: 300,
                  fit: BoxFit.cover,
              ),
                ),           
            Container(            
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(3.0),
                    child: Text(noti.texto, style:Theme.of(context).textTheme.bodyText2)),
                  SizedBox(height: 20.0,),
                  Container(                
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [   
                        Container(
                          width: 200,
                          child: Text(noti.link, style:Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,)
                          ),                                    
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
        helper.abrirLink(noti.link);
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

 
  
  Widget _floatingB() {    
    return FloatingActionButton(      
      child:  Icon(Icons.menu, size: 30.0,),
      backgroundColor: Colors.red,
      onPressed: (){  
       _scaffoldKey.currentState.openDrawer();
      },
    );
  }



  Widget _crearTarjeta2(Noticia noti){
    Color colorImp = Colors.green;
    if(noti.importancia==1)colorImp=Colors.red;
    final size=MediaQuery.of(context).size;
      final tarjeta= Container(         
        margin: EdgeInsets.only(bottom:10.0 ),
        child: Stack(
          children: [
            Card(
              color:Theme.of(context).canvasColor,
              elevation: 20.0,
              child: Row(
                children: [
                 FadeInImage(                
                  image: NetworkImage("${noti.imagen}"),
                  placeholder: AssetImage("assets/1.gif"),
                  fadeInDuration: Duration(milliseconds: 200),
                  height: 100,
                  width: size.width *0.2,
                  fit: BoxFit.contain,
                ),
                Container(
                  width: size.width*0.7,
                  child: ListTile(
                    title: Text(noti.texto, style:Theme.of(context).textTheme.bodyText2),
                    subtitle: Column(
                      children: [
                        SizedBox(height: 5.0,),                      
                        Text(noti.link,style:TextStyle(color:Theme.of(context).primaryColorDark, fontSize: 12.0), overflow: TextOverflow.ellipsis,)
                      ],
                    ),
                  ),
                ),                
                ],
              ),
            ),
            //_etiqueta(noti.importancia)
            Container(
              height: 10.0,
              width: size.width*0.2,
              margin: EdgeInsets.only(left: 10.0),
              color: colorImp,
            )
          ],
        ),
      );

      return GestureDetector(
      child: tarjeta,
      onTap: (){
        helper.abrirLink(noti.link);
      },
    );

  }

  Widget _changeImport() {
  
    Color estado;
    vista==0?estado=Colors.red:estado=Colors.green;
    return MaterialButton(      
      child:  Icon(Icons.cached, size: 30.0, color: estado,),
      
      onPressed: (){  
        setState(() {
        vista==0?vista=1:vista=0;          
        });
      },
    );
 
}
}
 
