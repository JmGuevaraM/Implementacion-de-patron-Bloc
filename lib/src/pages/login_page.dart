import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: _crearScreen(context,_screenSize)

    );
  }


  Widget _crearScreen(BuildContext context,Size size){  
    return Stack(
      children: <Widget>[
        _colorFondo(size),
        Positioned(child: _title(),left: 180.0, top: 40.0,),
        _loginForm(context,size)
      ],
    );
  }

  Widget _loginForm(BuildContext context, Size size){

    final bloc = Provider.of(context);

    return  SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 200.0,
            )
          ),
          Container(
            width: size.width*0.85,
            decoration: BoxDecoration(
              color: Colors.white
            ),
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0,),
                Text('Inicio de Sesion',style: TextStyle(color: Colors.teal,fontSize: 16.0),),
                SizedBox(height: 20.0,),
                _emailField(bloc),
                SizedBox(height: 20.0,),
                _password(bloc),
                SizedBox(height: 50.0,),
                _ingresarbutton(bloc)
              ],
            ),
          ),
          FlatButton(
            onPressed: (){}, 
            child: Text('¿Olvido su password?', style: TextStyle(color: Colors.grey),))
        ],
      ),
    );
  }

  Widget _emailField(LoginBloc bloc){

    return StreamBuilder<String>(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.blue[200],
              ),
              hintText: 'Correo Electronico',
              hintStyle: TextStyle(fontSize: 12.0,fontStyle: FontStyle.italic),
              //counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      }
    
    );
    
  }

  Widget _password(LoginBloc bloc){

    return StreamBuilder<String>(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.blue[200],
              ),
              hintText: 'Password',
              hintStyle: TextStyle(fontSize: 12.0,fontStyle: FontStyle.italic),
             // counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword, //voy viendo lo que va entrando al stream
          ),
        );
      }
    
    );
  }

  Widget _ingresarbutton(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
      return RaisedButton(
          child: Text('Ingresar', style: TextStyle(fontSize: 16.0),),
          color: Colors.green,
          elevation: 5.0,
          shape: StadiumBorder(),
          textColor: Colors.white,  
          padding: EdgeInsets.only(left: 100.0, right: 100.0, bottom: 10.0, top: 10.0),         
          onPressed: snapshot.hasData? ()=>_ingresar(context, bloc) : null
      );
    });
  }

  _ingresar(BuildContext context, LoginBloc bloc){
    print('***********************');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');
    print('***********************');
    Navigator.pushNamed(context, 'home');
  }

//%%%%%%%%%%%%%%%%%%%%        DECORACION      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Widget _colorFondo(Size size){
    return Container(
          height: size.height*0.4,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0),
              colors: [
                Color.fromRGBO(3, 145, 140, 1.0),
                Color.fromRGBO(6, 105, 102, 1.0),
              ]
            )
          ),
          child: _decoracion(),
        );
  }
  Widget _decoracion(){
    return Stack(
      children: <Widget>[
        Positioned(child: _circuloA(),top: 100.0,),
        Positioned(child: _circuloB(),top: 65.0, left: 45.0,),
        Positioned(child: _circuloC(),top: 35.0, left: 25.0,),
      ],
    );
  }
  Widget _circuloA(){
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.teal[300],
        ),
        width: 100.0,
        height: 100.0,
      );  
  }
  Widget _circuloB(){
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.teal,
        ),
        width: 80.0,
        height: 80.0,
      );  
  }
  Widget _circuloC(){
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.teal[100],
        ),
        width: 65.0,
        height: 65.0,
        child: Icon(Icons.android,color: Colors.teal,),
      );  
  }

  Widget _title(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.perm_identity, color: Colors.white, size: 100,),
        Text('Hola, Jose Miguel',style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold, fontSize: 18.0 ),)//Nombre en Duro
      ],
    );
  }

//%%%%%%%%%%%%%%%%%%%%%%%%%%      FIN DECORACION      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //fin de LoginPage
}