import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productosProvider = new ProductosProvider();

  @override
  void initState() {
    // TODO: implement initState
    _crearListado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('AppHome'),
        centerTitle: true,
      ),
      body: _crearListado(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: ()=> Navigator.pushNamed(context, 'producto')
      ),
    );
  }

  Widget _crearListado(){
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        final productos = snapshot.data;
        if(snapshot.hasData){
         
          return ListView.builder(

            itemCount: productos.length,
            itemBuilder: (context, i)=> _crearItem(context, productos[i])             
          );
          
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto){
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red,),
      /* child: ListTile(
        title: Text('${producto.titulo} - ${producto.valor.toString()}'),
        subtitle: Text('id: ${producto.id}'),
        onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto),
      ), */
      child: Card(
        child: Column(
          children: <Widget>[

            ( producto.fotoUrl == null ) 
              ? Image(image: AssetImage('assets/no-image.png'))
              : FadeInImage(
                image: NetworkImage( producto.fotoUrl ),
                placeholder: AssetImage('assets/jar-loading.gif'),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            
            ListTile(
              title: Text('${ producto.titulo } - ${ producto.valor }'),
              subtitle: Text( producto.id ),
              onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto ),
            ),

          ],
        ),
      ),
      onDismissed: (direction) => productosProvider.borrarProducto(producto.id),
    );
  }
}