import 'package:flutter/material.dart';

class HorarioPage extends StatefulWidget {
  @override
  _HorarioPageState createState() => _HorarioPageState();
}
List<String> _dayNames=["Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado"];
//List<String> _images=["assets/house.jpg","assets/house.jpg","assets/glob.jpg","assets/scroll-1.png","assets/glob.jpg","assets/scroll-1.png","assets/glob.jpg"];
class _HorarioPageState extends State<HorarioPage> {
   String day=_dayNames[DateTime.now().weekday-1];
   double _valorporciento=0;
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
            icon: Icon (Icons.add_circle,size: 30.0,color: Colors.black,),
            onPressed: (){
              Navigator.pushNamed(context, "addMateria");
            },
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
                initialPage: DateTime.now().weekday-1,
              ),
              children: [
                Container(),
                _day("lunes"),
                _day("martes"),
                _day("miercoels"),
                _day("jueves"),
                _day("viernes"),
                _day("sabado"),                
              ],
              onPageChanged:(index){
                  setState(() { 

                    day=_dayNames[index];
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
    //color: Color.fromRGBO(170, 215, 221, 1.0),
   child: Image(
      image:AssetImage("assets/scroll-1.png"),
      fit: BoxFit.cover,
   ),
    
  );
}

Widget _day(String day){    
   
  return  Container(    
    child: ListView.builder(
      itemCount: 12,
      controller: PageController(
        initialPage: 8
      ),    
              
      itemBuilder: (context,index){        
        barProgress(index);
        return Container(          
          child: Column(
            children: [
              _tarjetas(index, _valorporciento),
              SizedBox(height: 1.0,)
            ],
          ),
        );
      }
      
      ),
   
  );
  
}
void barProgress(int index){
if(index == DateTime.now().hour-13){
        _valorporciento=DateTime.now().minute/60;
        }
        else{
          if(index < DateTime.now().hour-13)
          _valorporciento=1.0;
          else
           _valorporciento=0.0;

        } 

}

Widget _tarjetas(int index, double vaslor){  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),        
        child: Container(        
           color: Color.fromRGBO(48, 48, 48, 1.0),  
        child: Column(          
          children: [
            SizedBox(height: 4.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.fiber_manual_record, color: Colors.blue,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("8:00-9:00 Hrs", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    Text("nombre de la materia", style: TextStyle(color: Colors.white)),
                  ],
                ),
                 FlatButton(
                   color: Colors.transparent,
                   child: Column(
                     children: [                                   
                       Icon(Icons.arrow_drop_down,size: 50.0,color: Colors.pinkAccent,)
                     ],
                   ),
                   onPressed: (){
                     ///
                   },
                 ),
              ],
            ),
            SizedBox(height: 15.0,),
             LinearProgressIndicator(               
              value:vaslor,
              minHeight: 10.0,
              backgroundColor: Colors.red[100],
              valueColor:new AlwaysStoppedAnimation<Color>(Colors.green),                                
            ),
          ],
        )
      ),
    ),
  );
}
 
}




/*Card(
                  elevation: 20.0,   
                  color: Color.fromRGBO(48, 48, 48, 1.0),                         
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
      ), */