import 'package:formvalidation/src/models/producto_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Los provider son tambien llamados servicios, este tipo de archivo son los encargados de 
//interactuar con el backend


class ProductosProvider {
  
  final String _url = 'https://flutter-varios-895ff.firebaseio.com' ;

  //POST en Database de Firebase

  Future<bool>guardarProducto(ProductoModel producto) async{
    final url = '$_url/productos.json';
    
    try{
      final resp = await http.post(url, body: productoModelToJson(producto));
      final decodeData = json.decode(resp.body);
      print(decodeData);
    }catch(e){
      print(e);
      return false;
    }
    return true;
  }

  //GET en Database de Firebase

  Future<List<ProductoModel>>cargarProductos() async{
    final url = '$_url/productos.json';
    final resp = await http.get(url);

    final List<ProductoModel> productosExtraidos = new List();

    final Map<String, dynamic> decodeData = json.decode(resp.body);

    //Validacion Recomendada
    if(decodeData == null) return [];

    decodeData.forEach((id, prod) { 
      //Debo llamar al Constructor del modelo para construir cada producto
      final prodTemp = ProductoModel.fromJson(prod); //este metodo solo le tengo que pasar el json 
      prodTemp.id = id;

      //Armo la lista de los productos extraidos:
      productosExtraidos.add(prodTemp);
    });
   // print(productosExtraidos);
    return productosExtraidos ;
  }

  //DELETE en Database de Firebase

  Future<bool>borrarProducto(String id) async{
    final url = '$_url/productos/$id.json';
    await http.delete(url);
    
    return true;
  }

  //PUT en Database de Firebase

  Future<bool>editarProducto(ProductoModel producto) async{
    final url = '$_url/productos/${producto.id}.json';
    
    try{
      final resp = await http.put(url, body: productoModelToJson(producto));
      final decodeData = json.decode(resp.body);
      print(decodeData);
    }catch(e){
      print(e);
      return false;
    }
    return true;
  }


}