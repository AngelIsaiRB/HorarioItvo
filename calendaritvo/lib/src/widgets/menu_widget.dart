import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(                  
      child: Container(        
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
            leading: Icon(Icons.home, color: Theme.of(context).primaryColor,),
            title: Text("Horario", style: Theme.of(context).textTheme.bodyText1,),
            onTap: (){
                Navigator.pushReplacementNamed(context, "homepage");
            },
          ),
          ListTile(
            leading: Icon(Icons.new_releases, color: Theme.of(context).primaryColor,),
            title: Text("Noticias",  style: Theme.of(context).textTheme.bodyText1,),
            onTap: (){
                Navigator.pushNamed(context, "info");
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor,),
            title: Text("Calendario", style: Theme.of(context).textTheme.bodyText1,),
            onTap: (){
              Navigator.pushNamed(context, "calendario");
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Theme.of(context).primaryColor,),
            title: Text("Contacto", style: Theme.of(context).textTheme.bodyText1,),
            onTap: (){
              Navigator.pushNamed(context, "contact");
            },
          ),
          /*
          ListTile(
            leading: Icon(Icons.map, color: Theme.of(context).primaryColor,),
            title: Text("Mapa",  style: Theme.of(context).textTheme.bodyText1,),
            onTap: (){
              Navigator.pushNamed(context, "calendario");            
            },
          ),
          */
          ListTile(
            leading: Icon(Icons.subject, color: Theme.of(context).primaryColor,),
            title: Text("SII", style: Theme.of(context).textTheme.bodyText1,),
            onTap: (){
              abrirLink("https://www.voaxaca.tecnm.mx/sistema-integral-de-informacion/");            
            },
          ), 
           ListTile(
            leading: Icon(Icons.settings, color: Theme.of(context).primaryColor,),
            title: Text("Ajustes",  style: Theme.of(context).textTheme.bodyText1,),
            onTap: (){
              Navigator.pushNamed(context, "settings");            
            },
          ),        
          ],
        ),
      ),
    );
  }
}

abrirLink(String link)async{
    if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Could not launch $link';
  }
  }