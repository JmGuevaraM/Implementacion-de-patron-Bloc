import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/producto_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Provider(
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.teal
          ),
          initialRoute: 'home', // por ahora no me interesa la autenticacion
          title: 'FormBloc',
          routes:{
            'login'    : (BuildContext context) => LoginPage(),
            'home'     : (BuildContext context) => HomePage(),
            'producto' : (BuildContext context) => ProductoPage()
          }
          
        ),
    );
  }
}