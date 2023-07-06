import 'package:flutter/material.dart';

import '../view/cliente_view.dart';

class ClienteScreen extends StatelessWidget {
  final ClienteView clienteView;

  ClienteScreen({required this.clienteView});

  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Cliente'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: 'Nome'),
          ),
          TextField(
            controller: _telefoneController,
            decoration: InputDecoration(labelText: 'Telefone'),
          ),
          ElevatedButton(
            child: Text('Adicionar Cliente'),
            onPressed: () {
              clienteView.adicionarCliente(_nomeController.text, _telefoneController.text);
              _nomeController.clear();
              _telefoneController.clear();
              Navigator.pop(context); // Volte para a ClienteListScreen.
            },
          ),
        ],
      ),
    );
  }
}
