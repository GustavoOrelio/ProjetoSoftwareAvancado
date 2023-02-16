import 'package:flutter/material.dart';

import 'components/primeira_pagina.dart';

class Inicializador extends StatelessWidget {
  const Inicializador({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu aplicativo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PrimeiraPagina(),
    );
  }
}
