import 'package:flutter/material.dart';

class HorarioPage extends StatefulWidget {
  @override
  _HorarioPageState createState() => _HorarioPageState();
}
List<String> _dayNames=["Domingo","Lunes","Martes","Miercoels","Jueves","Viernes","Sabado"];
//List<String> _images=["assets/house.jpg","assets/house.jpg","assets/glob.jpg","assets/scroll-1.png","assets/glob.jpg","assets/scroll-1.png","assets/glob.jpg"];
class _HorarioPageState extends State<HorarioPage> {
   String day=_dayNames[DateTime.now().weekday-1];
  // String image=_images[DateTime.now().weekday-1];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: Text(day,style: TextStyle(color:Colors.black,fontSize:35.0, fontStyle: FontStyle.italic  ),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon (Icons.playlist_add,size: 30.0,color: Colors.black,),
            onPressed: (){},
            )
        ],
        
      ), 
        body: Stack(
        children: [          
          _imagenFondo(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: PageView(              
              scrollDirection: Axis.horizontal,             
              controller: PageController(
                initialPage: DateTime.now().weekday-2,
              ),
              children: [
                _day("lunes"),
                _day("martes"),
                _day("miercoels"),
                _day("jueves"),
                _day("viernes"),
                _day("sabado"),                
              ],
              onPageChanged:(index){
                  setState(() {
                    day=_dayNames[index+1];
                   // image=_images[index+1];
                  });
              },              
            ),
          ),
        ],
      ),
    );


  }


  Widget _imagenFondo(){    
  return Container(
    width: double.infinity,
    height: double.infinity,
    child: Image(
      image:AssetImage("assets/scroll-1.png"),
      fit: BoxFit.cover,
    ),
    
  );
}

Widget _day(String day){    
  List<String> nameday=["Domingo","Lunes","Martes","Miercoels","Jueves","Viernes","Sabado"]; 
  return  Container(    
    child: ListView.builder(
      itemCount: 12,
      itemBuilder: (context,index){
        return Container(
          child: Column(
            children: [
              _tarjetas(),
              SizedBox(height: 5.0,)
            ],
          ),
        );
      }
      
      ),
   
  );
  
}


Widget _tarjetas(){
  return ClipRRect(
    borderRadius: BorderRadius.circular(40.0),
      child: Container(
    decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(1.0,1.0) ,
            end:   FractionalOffset(0.1,0.1), 
           colors: [
             Color.fromRGBO(227, 255, 251,0.7),
             Color.fromRGBO(21, 10, 53,0.7),
           ]
          ),
    ),      
      child: Card(
                  elevation: 20.0,   
                  color: Colors.transparent,                         
                  child: Column(                
                    children: [
                      ListTile(                              
                        leading: Icon(Icons.fiber_manual_record, color: Colors.blue,),
                        title:Text("8:00-9:00", style: TextStyle(color: Colors.white),),                          
                        subtitle: 
                            Text("nombre de la materia", style: TextStyle(color: Colors.white)),                                                       
                        trailing: 
                          Container(                           
                                                   
                              child: FlatButton(
                                color: Colors.transparent,
                                child: Column(
                                  children: [                                   
                                    Icon(Icons.arrow_drop_down,size: 50.0,color: Colors.pinkAccent,)
                                  ],
                                ),
                                onPressed: (){},
                              ),
                            
                          )
                                                         
                      ),       
                     LinearProgressIndicator(
                                value: 0.5,
                                minHeight: 10.0,
                                backgroundColor: Colors.red[100],
                                valueColor:new AlwaysStoppedAnimation<Color>(Colors.green),                                
                              ),
                    ],                  
                  ),
      ),
    ),
  );
}
 
}