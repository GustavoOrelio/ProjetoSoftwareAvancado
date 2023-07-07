import 'package:beauty_time/view/cliente_view.dart';
import 'package:beauty_time/view/funcionario_view.dart';
import 'package:beauty_time/view/servico_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain/dto/agendamento_dto.dart';
import '../domain/dto/cliente_dto.dart';
import '../domain/dto/servico_dto.dart';
import '../view/agendamento_view.dart';
import 'agendamento_screen.dart';

class AgendamentoListScreen extends StatefulWidget {
  final AgendamentoView agendamentoView;
  final ClienteView clienteView;
  final FuncionarioView funcionarioView;
  final ServicoView servicoView;

  AgendamentoListScreen(
      {required this.agendamentoView,
      required this.clienteView,
      required this.funcionarioView,
      required this.servicoView});

  @override
  _AgendamentoListScreenState createState() => _AgendamentoListScreenState();
}

class _AgendamentoListScreenState extends State<AgendamentoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamentos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AgendamentoScreen(
                          agendamentoView: widget.agendamentoView,
                          clienteView: widget.clienteView,
                          funcionarioView: widget.funcionarioView,
                          servicoView: widget.servicoView,
                        )),
              ).then((_) {
                setState(
                    () {}); // Atualize a lista de agendamentos quando voltar.
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<AgendamentoDTO>>(
        future: widget.agendamentoView.obterTodosAgendamentos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ocorreu um erro!'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, i) => FutureBuilder<ClienteDTO>(
                future: widget.clienteView.obterClientePorId(snapshot.data![i].clienteId),
                builder: (context, snapshotCliente) {
                  if (snapshotCliente.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshotCliente.error != null) {
                    return Text('Ocorreu um erro!');
                  } else {
                    return FutureBuilder<ServicoDTO>(
                      future: widget.servicoView.obterServicoPorId(snapshot.data![i].servicoId),
                      builder: (context, snapshotServico) {
                        if (snapshotServico.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshotServico.error != null) {
                          return Text('Ocorreu um erro!');
                        } else {
                          return ListTile(
                            title: Text('${snapshotCliente.data!.nome} - ${snapshotServico.data!.nome}'),
                            subtitle: Text(DateFormat('dd/MM/yyyy - HH:mm').format(snapshot.data![i].dataHora)),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                widget.agendamentoView.removerAgendamento(snapshot.data![i].id);
                                setState(() {}); // Atualize a lista de agendamentos.
                              },
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
