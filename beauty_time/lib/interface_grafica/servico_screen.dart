import 'package:flutter/material.dart';

import '../view/servico_view.dart';

class ServicoScreen extends StatelessWidget {
  final ServicoView servicoView;

  ServicoScreen({required this.servicoView});

  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Serviço'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: 'Nome'),
          ),
          TextField(
            controller: _precoController,
            decoration: InputDecoration(labelText: 'Preço'),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            child: Text('Adicionar Serviço'),
            onPressed: () {
              double preco = double.tryParse(_precoController.text) ?? 0.0;
              servicoView.adicionarServico(_nomeController.text, preco);
              _nomeController.clear();
              _precoController.clear();
              Navigator.pop(context); // Volte para a ServicoListScreen.
            },
          ),
        ],
      ),
    );
  }
}
