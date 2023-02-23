import 'package:flutter/material.dart';

import 'view/primeiraPagina.dart';

class Inicializador extends StatelessWidget {
  const Inicializador({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aula',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrimeiraPagina(),
    );
  }
}
