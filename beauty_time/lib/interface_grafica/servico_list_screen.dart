import 'package:beauty_time/interface_grafica/servico_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain/dto/servico_dto.dart';
import '../view/servico_view.dart';

class ServicoListScreen extends StatefulWidget {
  final ServicoView servicoView;

  ServicoListScreen({required this.servicoView});

  @override
  _ServicoListScreenState createState() => _ServicoListScreenState();
}

class _ServicoListScreenState extends State<ServicoListScreen> {
  @override
  Widget build(BuildContext context) {
    final realFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Scaffold(
      appBar: AppBar(
        title: Text('Serviços'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ServicoScreen(servicoView: widget.servicoView)),
              ).then((_) {
                setState(() {}); // Atualize a lista de serviços quando voltar.
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ServicoDTO>>(
        future: widget.servicoView.obterTodosServicos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ocorreu um erro!'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(snapshot.data![i].nome), // Aqui você pode querer mostrar o nome do serviço.
                subtitle: Text(realFormat.format(snapshot.data![i].preco)), // Aqui você mostra o preço do serviço.
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    widget.servicoView.removerServico(snapshot.data![i].id);
                    setState(() {}); // Atualize a lista de serviços.
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
