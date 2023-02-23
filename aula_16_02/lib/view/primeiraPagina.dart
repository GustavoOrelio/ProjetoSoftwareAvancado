import 'package:aula_16_02/view/validaCnpj.dart';
import 'package:aula_16_02/view/validaCpf.dart';
import 'package:flutter/material.dart';

class PrimeiraPagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Valide Aqui'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Valide seu CPF'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ValidaCpf()),
                );
              },
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text('Valide seu CNPJ'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ValidaCnpj()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
