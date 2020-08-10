
import 'dart:async';

// Validaciones Personalizadas usando StreamTransformer
class Validators {

  final validarEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email, sink) {
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      

      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError('Email no válido');
      }
    },
  );

  final validarPassword = StreamTransformer<String,String>.fromHandlers(
    handleData: (password, sink) {
      Pattern pattern = r'[A-Z]';//Esto es cuando la password debe contener al menos 1 mayuscula
      RegExp regExp = new RegExp(pattern);
      

      if(password.length >= 6 && regExp.hasMatch(password)){
        sink.add(password);
      }else{
        sink.addError('Password no válido');
      }
    },
  );
  
}