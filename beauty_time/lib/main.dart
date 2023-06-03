import 'package:beauty_time/infrastructure/dao_cliente.dart';
import 'package:beauty_time/view/cliente/lista_cliente.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BeautyTime',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ListaClientesPage(clienteRepository: ClienteDAO()),
    );
  }
}
