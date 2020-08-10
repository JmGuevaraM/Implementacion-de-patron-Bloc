import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:formvalidation/src/bloc/validators.dart';

class LoginBloc with Validators{

  /* final _emailController    = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast(); */

  final _emailController    = BehaviorSubject<String>(); //Para implementar la combinacion de Streams usamos el paquete de RxDart
  final _passwordController = BehaviorSubject<String>(); //Para el Combine no se usa 'StreamController' sino 'BehaviorSubject'
                             // los BehaviorSubject son 100% compatibles con los StreamController 

  //Entrada de valores al Stream
  Function get changeEmail    => _emailController.sink.add;
  Function get changePassword => _passwordController.sink.add;

  //Salida de los valores del Stream
  Stream<String> get emailStream    => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  //Combinar 2 Streams
  Stream<bool> get formValidStream => 
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //Obtener los valores de los stream

  String get email => _emailController.value;
  String get password => _passwordController.value;

  //Metodo para cerrar el stream cuando no lo necesite
  void disposeStreams(){
    _emailController?.close();    //El signo ? es para evitar error si el controller fuese null
    _passwordController?.close();
  }

  
}