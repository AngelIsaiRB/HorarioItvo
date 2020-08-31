import 'package:calendaritvo/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class CalendarioPage extends StatelessWidget {
  const CalendarioPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text("Calendario", style: TextStyle(color: Colors.black, fontSize: 25.0),),
      ),
      body: Center(
        
      ),
      drawer: MenuWidget(),
    );
  }
}