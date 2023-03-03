import 'package:flutter/material.dart';
import 'package:venda/view/venda.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha loja',
      home: TelaVenda(),
    );
  }
}