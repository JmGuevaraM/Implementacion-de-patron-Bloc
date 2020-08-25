import 'dart:io';

import 'package:formvalidation/src/models/producto_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

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

  //Subir la imagen a la API

   Future<String> subirImagen( File imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dc0tufkzf/image/upload?upload_preset=cwye3brj');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add(file);


    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }

    final respData = json.decode(resp.body);
    print( respData);

    return respData['secure_url'];


  } 


}