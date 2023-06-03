import 'package:beauty_time/domain/dto/cliente_dto.dart';
import 'package:beauty_time/domain/porta/i_cliente.dart';
import 'package:beauty_time/view/cliente/adicionar_cliente.dart';
import 'package:beauty_time/view/cliente/detalhes_cliente.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ListaClientesPage extends StatefulWidget {
  final ClienteRepository clienteRepository;
  final StreamController _streamController = StreamController();

  ListaClientesPage({Key? key, required this.clienteRepository})
      : super(key: key);

  @override
  _ListaClientesPageState createState() => _ListaClientesPageState();
}

class _ListaClientesPageState extends State<ListaClientesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: StreamBuilder(
        stream: widget._streamController.stream,
        builder: (context, snapshot) {
          return FutureBuilder<List<ClienteDTO>>(
            future: widget.clienteRepository.getClientes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final cliente = snapshot.data![index];
                    return ListTile(
                        title: Text(cliente.nome),
                        subtitle: Text(cliente.telefone),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await widget.clienteRepository
                                .deleteCliente(cliente.id);
                            widget._streamController.add(null);
                          },
                        ),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesClientePage(
                                clienteRepository: widget.clienteRepository,
                                cliente: cliente,
                              ),
                            ),
                          );
                          widget._streamController.add(null);
                        });
                  },
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar clientes'));
              }
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdicionarClientePage(
                clienteRepository: widget.clienteRepository,
              ),
            ),
          );
          widget._streamController.add(null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
