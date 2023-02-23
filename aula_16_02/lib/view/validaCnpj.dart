import 'package:aula_16_02/widgets/validarCnpj.dart';
import 'package:flutter/material.dart';

class ValidaCnpj extends StatefulWidget {
  @override
  _ValidadorCnpjState createState() => _ValidadorCnpjState();
}

class _ValidadorCnpjState extends State<ValidaCnpj> {
  final _cnpjController = TextEditingController();
  bool _cnpjValido = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validador de CNPJ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Insira o CNPJ:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: _cnpjController,
                keyboardType: TextInputType.number,
                maxLength: 18,
                decoration: InputDecoration(
                  hintText: '00.000.000/0000-00',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _cnpjValido = ValidarCNPJ(_cnpjController.text);
                });
              },
              child: Text('Validar CNPJ'),
            ),
            SizedBox(height: 20),
            Text(
              _cnpjValido ? 'CNPJ válido!' : 'CNPJ inválido.',
              style: TextStyle(
                fontSize: 18,
                color: _cnpjValido ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}