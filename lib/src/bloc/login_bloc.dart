

import 'dart:async';

class LoginBloc {

  final _emailController    = StreamController.broadcast();
  final _passwordController = StreamController.broadcast();

  //Entrada de valores al Stream
  Function get changeEmail    => _emailController.sink.add;
  Function get changePassword => _passwordController.sink.add;

  //Salida de los valores del Stream
  Stream get emailStream    => _emailController.stream;
  Stream get passwordStream => _passwordController.stream;

  //Metodo para cerrar el stream cuando no lo necesite
  void disposeStreams(){
    _emailController?.close();    //El signo ? es para evitar error si el controller fuese null
    _passwordController?.close();
  }

  
}