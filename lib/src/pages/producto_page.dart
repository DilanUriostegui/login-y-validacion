
import 'package:flutter/material.dart';

import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  ProductoModel producto = ProductoModel();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual), 
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt), 
            onPressed: (){},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value)=> producto.titulo = value,
      validator: (value){
        if( value.length < 3 ){
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }

  Widget _crearPrecio(){
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value)=> producto.valor = double.parse(value),
      validator: ( value ){
        if( utils.isNumeric(value) ){
          return null;
        }
        else{
          return 'Sólo números';
        }
      },
    );

  }

  Widget _crearDisponible(){
    return SwitchListTile(
      value: producto.disponible, 
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: ( value )=> setState((){
        producto.disponible = value;
      }

      ),
    );
  }

  Widget _crearBoton(){
    return ElevatedButton.icon(
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        )),
        backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
        textStyle: MaterialStateProperty.all(TextStyle(
          color: Colors.white
        ))
      ),
      onPressed: _submit,
    );
  }

  void _submit(){

    if( !formKey.currentState.validate() ) return;

    formKey.currentState.save();

    print('Todo OK!');

    print(producto.titulo);
    print( producto.valor );
    print( producto.disponible );

    
  }
}