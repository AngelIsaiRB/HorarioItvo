import 'package:flutter/material.dart';
class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Noticias", style: TextStyle(color: Colors.black, fontSize: 30.0 ), ),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
      ),
      body: Container(        
        child: Center(        
          child: Text("En construccion noticias, clendario e informacion importante del ITVO",
                      style: TextStyle(color: Colors.black, fontSize: 25.0),),
        ),
      ),

    );
  }
}