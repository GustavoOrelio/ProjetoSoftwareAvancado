import 'package:aula_16_02/view/validaCnpj.dart';
import 'package:aula_16_02/view/validaCpf.dart';
import 'package:flutter/material.dart';

class PrimeiraPagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Valide Aqui',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Valide seu CPF',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ValidaCpf()),
                );
              },
            ),
            SizedBox(height: 18.0),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Valide seu CNPJ',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
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
