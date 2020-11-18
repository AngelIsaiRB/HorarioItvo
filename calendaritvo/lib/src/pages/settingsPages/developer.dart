import 'package:calendaritvo/src/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Developer extends StatefulWidget {
  @override
  _DeveloperState createState() => _DeveloperState();
}

class _DeveloperState extends State<Developer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Developer", style: Theme.of(context).textTheme.headline2,),        
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
      ),
      body:Stack(
        children: [
          CircularProgressIndicator(),
          WebView(
            initialUrl: "https://angelisairamirezbazan.netlify.app",        
          ),
        ],
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

}