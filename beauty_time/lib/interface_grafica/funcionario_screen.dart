import 'package:flutter/material.dart';

import '../view/funcionario_view.dart';

class FuncionarioScreen extends StatelessWidget {
  final FuncionarioView funcionarioView;

  FuncionarioScreen({required this.funcionarioView});

  final _nomeController = TextEditingController();
  final _cargoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Funcionario'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: 'Nome'),
          ),
          TextField(
            controller: _cargoController,
            decoration: InputDecoration(labelText: 'Cargo'),
          ),
          ElevatedButton(
            child: Text('Adicionar Funcionario'),
            onPressed: () {
              funcionarioView.adicionarFuncionario(_nomeController.text, _cargoController.text);
              _nomeController.clear();
              _cargoController.clear();
              Navigator.pop(context); // Volte para a FuncionarioListScreen.
            },
          ),
        ],
      ),
    );
  }
}
