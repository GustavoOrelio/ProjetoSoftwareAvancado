import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../view/servico_view.dart';

class ServicoScreen extends StatelessWidget {
  final ServicoView servicoView;

  ServicoScreen({required this.servicoView});

  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final realFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

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
            onChanged: (value) {
              double? preco = double.tryParse(value);
              if (preco != null) {
                _precoController.text = realFormat.format(preco);
              }
            },
          ),
          ElevatedButton(
            child: Text('Adicionar Serviço'),
            onPressed: () {
              double preco = double.tryParse(_precoController.text.replaceAll('R\$', '').replaceAll(',', '.')) ?? 0.0;
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
