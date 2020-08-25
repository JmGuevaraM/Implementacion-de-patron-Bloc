import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productoProvider= new ProductosProvider();

  ProductoModel producto = new ProductoModel();
  bool _guardado = false;
  File foto ;

  @override
  Widget build(BuildContext context) {

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if(prodData != null){
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual), 
            onPressed: _seleccionarFoto
          ),
          IconButton(
            icon: Icon(Icons.camera_alt), 
            onPressed: _tomarFoto
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombreProduct(),
                _crearPrecioProduct(),
                _crearDisponible(),
                SizedBox(height: 15.0,),
                _crearBotonSave(context),
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget _crearNombreProduct(){
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (valor)=> producto.titulo = valor,//Este metodo 'onSaved', se ejecuta unicamente despues de haber validado el campo
      validator: (value)=> utils.isEmpty(value)?null:'Ingrese Producto',
    );
  }

  Widget _crearPrecioProduct(){
    return TextFormField(
      /* initialValue: producto.valor.toString(), */
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (valor)=> producto.valor = double.parse(valor),
      validator: (value)=>  utils.isNumeric(value)?null:'Solo Numeros',
    );
  }

  Widget _crearDisponible(){
    return SwitchListTile(
      title: Text('Disponible'),
      value: producto.disponible,
      onChanged: (value) {
        setState(() {
          producto.disponible = value;
        });
      },
    );
  }

  Widget _crearBotonSave(BuildContext context){
    return RaisedButton.icon(
      label: Text('Guardar'),
      textColor: Colors.white,
      shape: StadiumBorder(),
      icon: Icon(Icons.save),
      color: Theme.of(context).primaryColor,
      onPressed: _guardado?null:_submit,
    );
  }

  void _submit() async{
    if(formKey.currentState.validate() == true){
      print('ok');
      
      formKey.currentState.save(); //a traves de la llave formKey dispara los onSaved de todos los TextFormField que esten dentro de ese formulario
      setState(() { _guardado = true;});

      if ( foto != null ) {
        producto.fotoUrl = await productoProvider.subirImagen(foto);
      } 

      if (producto.id == null) {
        productoProvider.guardarProducto(producto);
      } else {
        productoProvider.editarProducto(producto);
      }
      setState(() { _guardado = false;});
      mostrarSnackbar('Registro Guardado');
      Navigator.pushNamed(context, 'home');
    }
  }


  void mostrarSnackbar(String mensaje){
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 10),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto() {
 
    if (producto.fotoUrl != null) {
 
      return FadeInImage(
        image: NetworkImage( producto.fotoUrl ),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
 
    } else {
 
      return Image(

        image: AssetImage( foto?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,

      );
    }
  }

  _seleccionarFoto() async {

    _procesarImagen( ImageSource.gallery );

  }

  _tomarFoto(){
    _procesarImagen( ImageSource.camera );
  }

  _procesarImagen(ImageSource origin) async {
    final _picker = ImagePicker();

    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    
    foto = File(pickedFile.path);

    if (foto != null) {
      producto.fotoUrl = null;
    }

    setState(() {});
  }

  //Fin
}