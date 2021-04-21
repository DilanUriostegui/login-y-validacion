
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider{

  final String _url = 'https://flutter-varios-ffbc4-default-rtdb.firebaseio.com';


  Future<bool> crearProducto( ProductoModel producto ) async{

    final url = Uri.parse('$_url/productos.json');

    final resp = await http.post( url, body: productoModelToJson(producto) );

    final decodedData = json.decode(resp.body);

    print( decodedData );
    return true;

  }

  Future<bool> editarProducto( ProductoModel producto ) async{

    final url = Uri.parse('$_url/productos/${ producto.id }.json');

    final resp = await http.put( url, body: productoModelToJson(producto) );

    final decodedData = json.decode(resp.body);

    print( decodedData );
    return true;

  }

  Future<List<ProductoModel>> cargarProductos() async{
    final url = Uri.parse('$_url/productos.json');
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<ProductoModel> productos = [];

    if(decodedData == null) return[];

    decodedData.forEach(( id , prod ) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);
      

    });

    return productos;
  } 

  Future<int> borrarProducto( String id ) async{

    final url = Uri.parse('$_url/productos/$id.json');
    final resp = await http.delete(url);

    print( json.decode(resp.body));

    return 1;
  }

}