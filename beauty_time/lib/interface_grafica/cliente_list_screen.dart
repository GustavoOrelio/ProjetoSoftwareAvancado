import 'package:flutter/material.dart';

import '../domain/dto/cliente_dto.dart';
import '../view/cliente_view.dart';
import 'cliente_screen.dart';

class ClienteListScreen extends StatefulWidget {
  final ClienteView clienteView;

  ClienteListScreen({required this.clienteView});

  @override
  _ClienteListScreenState createState() => _ClienteListScreenState();
}

class _ClienteListScreenState extends State<ClienteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ClienteScreen(clienteView: widget.clienteView)),
              ).then((_) {
                setState(() {}); // Atualize a lista de clientes quando voltar.
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ClienteDTO>>(
        future: widget.clienteView.obterTodosClientes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ocorreu um erro!'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(snapshot.data![i].nome),
                subtitle: Text(snapshot.data![i].telefone),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    widget.clienteView.removerCliente(snapshot.data![i].id);
                    setState(() {}); // Atualize a lista de clientes.
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
