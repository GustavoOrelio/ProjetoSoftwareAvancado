import 'package:beauty_time/domain/dto/funcionario_dto.dart';
import 'package:beauty_time/domain/porta/i_funcionario.dart';
import 'package:beauty_time/view/funcionario/adicionar_funcionario.dart';
import 'package:beauty_time/view/funcionario/detalhes_funcionario.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ListaFuncionariosPage extends StatefulWidget {
  final FuncionarioRepository funcionarioRepository;
  final StreamController _streamController = StreamController();

  ListaFuncionariosPage({Key? key, required this.funcionarioRepository})
      : super(key: key);

  @override
  _ListaFuncionariosPageState createState() => _ListaFuncionariosPageState();
}

class _ListaFuncionariosPageState extends State<ListaFuncionariosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionarios'),
      ),
      body: StreamBuilder(
        stream: widget._streamController.stream,
        builder: (context, snapshot) {
          return FutureBuilder<List<FuncionarioDTO>>(
            future: widget.funcionarioRepository.getFuncionarios(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final funcionario = snapshot.data![index];
                    return ListTile(
                        title: Text(funcionario.nome),
                        subtitle: Text(funcionario.telefone),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await widget.funcionarioRepository
                                .deleteFuncionario(funcionario.id);
                            widget._streamController.add(null);
                          },
                        ),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesFuncionarioPage(
                                funcionarioRepository: widget.funcionarioRepository,
                                funcionario: funcionario,
                              ),
                            ),
                          );
                          widget._streamController.add(null);
                        });
                  },
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar funcionarios'));
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
              builder: (context) => AdicionarFuncionarioPage(
                funcionarioRepository: widget.funcionarioRepository,
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
