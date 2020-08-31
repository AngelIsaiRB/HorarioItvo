import 'package:calendaritvo/src/pages/calendario_page.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/menu-img.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),
        ListTile(
          leading: Icon(Icons.home, color: Colors.blue,),
          title: Text("Horario", style: TextStyle(color: Colors.black),),
          onTap: (){
              Navigator.pushReplacementNamed(context, "homepage");
          },
        ),
        ListTile(
          leading: Icon(Icons.pages, color: Colors.blue,),
          title: Text("Noticias", style: TextStyle(color: Colors.black),),
          onTap: (){
              Navigator.pushNamed(context, "info");
          },
        ),
        ListTile(
          leading: Icon(Icons.party_mode, color: Colors.blue,),
          title: Text("Calendario", style: TextStyle(color: Colors.black),),
          onTap: (){
            Navigator.pushNamed(context, "calendario");
            
          },
        ),        
        ],
      ),
    );
  }
}