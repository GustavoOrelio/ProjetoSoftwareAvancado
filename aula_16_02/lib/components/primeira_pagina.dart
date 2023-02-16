import 'package:flutter/material.dart';

import '../widgets/validar.dart';
import 'campos_texto.dart';

class PrimeiraPagina extends StatelessWidget {
  const PrimeiraPagina({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu aplicativo'),
      ),
      body: Center(
        child: Column(
          children: [
            CampoCpf(context),
            BotaoVerificar(context),
          ],
        ),
      ),
    );
  }
}
