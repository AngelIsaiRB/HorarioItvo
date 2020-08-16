import 'package:flutter/material.dart';
class AddMateri extends StatefulWidget {
  AddMateri({Key key}) : super(key: key);

  @override
  _AddMateriState createState() => _AddMateriState();
}

class _AddMateriState extends State<AddMateri> {


  String _name="";
  Color _opcionSeleccionada=Colors.blue;
  List<Color> _colores=[Colors.blue,Colors.red,Colors.yellow,
                        Colors.black,Colors.brown,Colors.purple,Colors.orange,Colors.green,
                        Colors.indigo];
  final _materias=[{
    "name":"matemticas",
    "color":Colors.red,
    },{
    "name":"filosofia",
    "color":Colors.blue,
    }];
  
  @override
  Widget build(BuildContext context) {
   double c_width = MediaQuery.of(context).size.width*0.5;
    return Scaffold(
      backgroundColor: Color.fromRGBO(122, 236, 203, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: Text("Agrega nueva materia", style: TextStyle(color: Colors.black, fontSize: 25.0),),        
      ),
      body: ListView.builder(
        itemCount: _materias.length+1,
        itemBuilder: (BuildContext context, int index) {
          if(index==0){
            return Container(
              padding: EdgeInsets.all(10.0),
            child: _imput()
            );
          }
          else{
              return Container(                
                child: Card(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [ 
                    
                       Icon(Icons.fiber_manual_record, color: _materias[index-1]["color"],size: 40.0, ),
                       
                     Container(
                       width: c_width,
                       child: Text(_materias[index-1]["name"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20.0, ),                          
                             ),
                     ),
                        
                       
                      Container(
                        color: Colors.red[200],
                        child: FlatButton(
                          child: Text("Eliminar"),
                          onPressed: (){},
                         
                        ),
                      )
                   ],
                 ), 
                ),
              );
          }
       },
      ),
    );
  }

  Widget _imput(){
    return Container(
    child: ClipRRect(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Column(        
          children: [
               _crearInput(),
              _crearDropdown(),
              _boton(),
              
          ],
        ),
      ),
      borderRadius: BorderRadius.circular(30.0),    
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          spreadRadius: 2.0,
          offset: Offset(2,10),
        )
      ]     
    ),
  );
  }


  Widget _crearInput() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),        
        hintText: "Materia",
        labelText: "Nombre",
        helperText: "",       
        icon: Icon(Icons.add_box,size: 40.0,), 
      ),
      onChanged: (valor){
          _name=valor;          
      },
    );

  }

  List<DropdownMenuItem<Color>> getOpcionesDropDown(){
  List<DropdownMenuItem<Color>> lista =new List();
  _colores.forEach((item) {
    lista.add(DropdownMenuItem(
      child: Icon(Icons.fiber_manual_record,color: item,size: 40.0,),
      value: item,
    ));    
  });
  return lista;
}
Widget _crearDropdown(){

    return Row(
       
      children: [
       Icon(Icons.color_lens, size: 40.0,),
       SizedBox(width: 30.0,),
       Expanded(
         child: Container(           
           child: DropdownButton(            
            value: _opcionSeleccionada,
            items : getOpcionesDropDown(),            
            onChanged: (opt){
              setState(() {
                _opcionSeleccionada=opt;
              });
      },
    ),
         ),
       ),
      ],
    );
}

Widget _boton(){
  return Container(         
    margin: EdgeInsets.all(15.0),  
    child: FlatButton(      
      child: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 30.0),
        child: Text("Agregar", style: TextStyle(color: Colors.white, fontSize: 25.0),)
        ),
      onPressed: (){
        setState(() {
          _materias.add({"name":_name,
                        "color":_opcionSeleccionada});
        });
      },
    ),
  );
}



}