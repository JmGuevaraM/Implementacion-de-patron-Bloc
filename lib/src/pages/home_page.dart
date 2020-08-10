import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Email: ${bloc.email}'),
          Text('Password: ${bloc.password}'),
        ],
      )
    );
  }
}