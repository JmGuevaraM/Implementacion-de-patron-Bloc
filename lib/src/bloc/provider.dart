import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/login_bloc.dart';

//%%%%%%    ESTE ES EL ANCESTRO PERSONALIZADO DE MIS WIDGETS    %%%%%
//    Este Provider puede manejar multiples instancias de bloc, blocs de diferentes objetos

class Provider extends InheritedWidget {

  //Se crea una instancia para manejar el bloc creado
  final loginBloc = LoginBloc();

  Provider({Key key, Widget child})
    :super(key: key, child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true; //Basicamente es una condicion : 
                                                              //Se actualiza este ancestro? notifica a sus hijos

  static LoginBloc of (BuildContext context){
    return(context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc);
  }
}