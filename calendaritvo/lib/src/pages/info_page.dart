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
    return ListTile(
      title: Text("${noti.texto}"),
      subtitle: Text("${noti.link}"),
      onTap: (){
        abrirLink(noti.link);
      },
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