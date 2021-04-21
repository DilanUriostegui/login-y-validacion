import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';

import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productosProvider = ProductosProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(){
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if(snapshot.hasData){
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: ( context, i ) => _crearItem(context, productos[i] ),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context ,ProductoModel producto){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direccion ){
        productosProvider.borrarProducto(producto.id);
      },
      child: Card(
        child: Column(
          children: [
            ( producto.fotoUrl == null || producto.fotoUrl == '') 
              ? Image(image: AssetImage('assets/no-image.png'))
              : FadeInImage(
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  image: NetworkImage(producto.fotoUrl),
                  height: 300.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
            ListTile(
              title: Text('${producto.titulo} - ${producto.valor}'),
              subtitle: Text(producto.id),
              onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto )
                  .then((value) => setState((){})),
            ),
          ],
        ),
      )
    );
  }



  

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=> Navigator.pushNamed(context, 'producto')
          .then((value) => setState((){})),
    );
  }
}