import 'package:beauty_time/domain/dto/servico_dto.dart';
import 'package:beauty_time/domain/porta/i_servico.dart';
import 'package:beauty_time/view/servico/adicionar_servico.dart';
import 'package:beauty_time/view/servico/detalhes_servico.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ListaServicosPage extends StatefulWidget {
  final ServicoRepository servicoRepository;
  final StreamController _streamController = StreamController();

  ListaServicosPage({Key? key, required this.servicoRepository})
      : super(key: key);

  @override
  _ListaServicosPageState createState() => _ListaServicosPageState();
}

class _ListaServicosPageState extends State<ListaServicosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicos'),
      ),
      body: StreamBuilder(
        stream: widget._streamController.stream,
        builder: (context, snapshot) {
          return FutureBuilder<List<ServicoDTO>>(
            future: widget.servicoRepository.getServicos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final servico = snapshot.data![index];
                    return ListTile(
                        title: Text(servico.nome),
                        subtitle: Text(servico.valor),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await widget.servicoRepository
                                .deleteServico(servico.id);
                            widget._streamController.add(null);
                          },
                        ),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesServicoPage(
                                servicoRepository: widget.servicoRepository,
                                servico: servico,
                              ),
                            ),
                          );
                          widget._streamController.add(null);
                        });
                  },
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar servicos'));
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
              builder: (context) => AdicionarServicoPage(
                servicoRepository: widget.servicoRepository,
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
