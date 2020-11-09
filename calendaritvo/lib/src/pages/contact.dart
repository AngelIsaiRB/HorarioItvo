import 'package:calendaritvo/src/data/contact.dart';
import 'package:calendaritvo/src/models/contact_model.dart';
import 'package:calendaritvo/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';


class ContactPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text("Contacto",  style: Theme.of(context).textTheme.headline3,),
        centerTitle: true,
      ),
       drawer: MenuWidget(),
      body: _listDataContact(),
    );
  }

  ListView _listDataContact(){
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: contactos.length,
      separatorBuilder: (BuildContext context, int index)=>Divider(),
      itemBuilder: (BuildContext context, int index) {
        return _contact(contactos[index]);
     },
    );
  }

  ListTile _contact(ContactModel contact){
    return ListTile(
      title: Text("${contact.nombre}"),
      subtitle: Text("${contact.link}"),
      leading: Icon(contact.icon),
      
      onTap: (){
      
         abrirLink(contact.link);
       
      },
    );
  }


}