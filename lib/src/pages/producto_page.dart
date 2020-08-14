import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final productoProvider= new ProductosProvider();

  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if(prodData != null){
      producto = prodData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual), 
            onPressed: (){}
          ),
          IconButton(
            icon: Icon(Icons.camera_alt), 
            onPressed: (){}
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
      initialValue: producto.valor.toString(),
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
      onPressed: _submit,
    );
  }

  void _submit(){
    if(formKey.currentState.validate() == true){
      print('ok');
      
      formKey.currentState.save(); //a traves de la llave formKey dispara los onSaved de todos los TextFormField que esten dentro de ese formulario

      print(producto.titulo);
      print(producto.disponible);
      print(producto.valor.toString());

      if (producto.id == null) {
        productoProvider.guardarProducto(producto);
      } else {
        productoProvider.editarProducto(producto);
      }

    }else{
      print('Not ok');

    }
      
  }
}