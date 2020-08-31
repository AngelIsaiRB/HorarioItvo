import 'package:calendaritvo/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

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
      
      body: PageView(        
        children: [
          _paginas("1"),
          _paginas("2"),
          _paginas("3")
        ],
      )

    );
  }

  Widget _paginas(String pg) {
    return Container(
      child: Center(
       
      ),
    );
  }
}