import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            title: Text("Calificaciones",style: Theme.of(context).textTheme.headline3 ,),
            centerTitle: true,
            actions: [
              Container(
                margin: EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon (Icons.add_circle,size: 40.0,color: Theme.of(context).primaryColor,),
                  onPressed: (){
                    Navigator.pushNamed(context, "addMateria");
                  },
                  ),
              )
            ],
            
          ),
    );
  }
}