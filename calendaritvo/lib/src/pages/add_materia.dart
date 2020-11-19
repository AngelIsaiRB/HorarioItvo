import 'package:calendaritvo/src/bloc/calificaiones_bloc.dart';
import 'package:calendaritvo/src/provider/db_c_provider.dart';
import 'package:flutter/material.dart';
import 'package:calendaritvo/src/bloc/Materias_bloc.dart';
import 'package:calendaritvo/src/data/data_list.dart' as data;
import 'package:calendaritvo/src/models/materia_model.dart';
import 'package:calendaritvo/src/utils/colos_string.dart' as utils;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddMateri extends StatefulWidget {
  AddMateri({Key key}) : super(key: key);

  @override
  _AddMateriState createState() => _AddMateriState();
}

class _AddMateriState extends State<AddMateri> {
  String _name = "";
  Color _opcionSeleccionada = Colors.red;
  

  final materiasBloc = MateriasBlock();
  final calificacionesBlock = CalificacionesBlock();

  @override
  Widget build(BuildContext context) {
    materiasBloc.obtenerMaterias();
    

    return Scaffold(
      backgroundColor: Colors.white, // Color.fromRGBO(122, 236, 203, 1.0),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text(
          "Nueva materia",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),

      body: _listViewMaterias(),

      floatingActionButton: FloatingActionButton.extended(
        heroTag: "s",
        onPressed: () {
          _mostrarAlerta(context);
        },
        label: Text("Agregar materia"),
        icon: Icon(
              Icons.add,
              size: 40,
            ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }

  Widget _listViewMaterias() {
    return StreamBuilder(
      stream: materiasBloc.materiasStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<MateriaModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final materia = snapshot.data;
        if (materia.length == 0) {
          return Center(
            child: Text("No hay materias"),
          );
        }
        return ListView.builder(
            itemCount: materia.length,
            itemBuilder: (BuildContext context, int index) => Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.delete, size: 40.0,),
                        Icon(Icons.delete, size: 40.0),
                      ],
                    ),
                  ),
                  onDismissed: (direcion) {
                   if (materia[index].name != "Libre"){
                       materiasBloc.deleteMateria(materia[index]);
                       DbCProvider.db.eliminarTodasCalificacionesDeMateria(materia[index]);
                   }
                  },
                  child: Card(
                     child: Container(
                      color: Theme.of(context).backgroundColor,//Colors.black12,
                      child: ListTile(                    
                        leading: Icon(
                          Icons.fiber_manual_record,
                          color: utils.stringToColor(materia[index].color),
                        ),
                        title: Text("${materia[index].name}",style:TextStyle(color: Colors.white, fontSize: 22.0) ),
                        subtitle: Text("Desliza para eliminar",style:TextStyle(color: Colors.white, fontSize: 15.0),),
                        trailing: Icon(FontAwesomeIcons.arrowsAltH, color: Colors.white,),
                      ),
                    ),
                  ),
                ));
      },
    );
  }

  Widget _imput(BuildContext context, setState) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          _crearInput(),
         _crearDropdown(context, setState)],
      ),
    );
  }

  Widget _crearInput() {
    return TextField(
      autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: "Materia",
        labelText: "Nombre",
        helperText: "",
        icon: Icon(
          Icons.calendar_today,
          size: 40.0,
        ),
      ),
      onChanged: (valor) {
        _name = valor;
      },
    );
  }

  List<DropdownMenuItem<Color>> getOpcionesDropDown() {
    List<DropdownMenuItem<Color>> lista = new List();
    for (var i = 0; i < data.colores.length; i++) {          
      lista.add(DropdownMenuItem(
        child: Row(
          children: [
            Icon(
              Icons.fiber_manual_record,
              color: data.colores[i],
              size: 40.0,
            ),
            Text(data.nombresColores[i],)
          ],
        ),
        value: data.colores[i],
      ));
    }
    return lista;
  }

  Widget _crearDropdown(BuildContext context, setState) {
    return Row(
      children: [
        Icon(
          Icons.color_lens,
          size: 40.0,
        ),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: Container(
            child: DropdownButton(
              value: _opcionSeleccionada,
              items: getOpcionesDropDown(),
              onChanged: (opt) {
                setState(() {
                  _opcionSeleccionada = opt;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  _mostrarAlerta(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,      
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState){
            return AlertDialog(
          
          title: Text("Agregar materia"),
          content: _imput( context, setState),          
          actions: [
            FlatButton(
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                "Agregar",
                style: TextStyle(fontSize: 25.0),
              ),
              onPressed: () {
                final materia = MateriaModel(name: _name,color: utils.coloToString(_opcionSeleccionada));
                calificacionesBlock.agregarMateria(materia);
                materiasBloc.agregarMateria(materia);
                _name = "";
                Navigator.pop(context);
              },
            )
          ],
        );
          },
        );
      },
    );
  }
}
