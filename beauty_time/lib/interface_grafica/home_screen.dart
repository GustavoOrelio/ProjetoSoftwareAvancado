import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../view/agendamento_view.dart';
import '../view/cliente_view.dart';
import '../view/servico_view.dart';
import '../domain/dto/agendamento_dto.dart';
import '../domain/dto/cliente_dto.dart';
import '../domain/dto/servico_dto.dart';

class HomePage extends StatelessWidget {
  final AgendamentoView agendamentoView;
  final ClienteView clienteView;
  final ServicoView servicoView;

  HomePage({
    required this.agendamentoView,
    required this.clienteView,
    required this.servicoView,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<AgendamentoDTO>>(
        future: agendamentoView.obterTodosAgendamentos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ocorreu um erro!'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, i) {
                AgendamentoDTO agendamento = snapshot.data![i];
                Future<ClienteDTO> cliente = clienteView.obterClientePorId(agendamento.clienteId);
                Future<ServicoDTO> servico = servicoView.obterServicoPorId(agendamento.servicoId);
                return FutureBuilder<ClienteDTO>(
                  future: cliente,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      String clienteNome = snapshot.data?.nome ?? 'Nome do cliente não disponível';
                      return FutureBuilder<ServicoDTO>(
                        future: servico,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            String servicoNome = snapshot.data?.nome ?? 'Nome do serviço não disponível';
                            return ListTile(
                              title: Text('Cliente: $clienteNome'),
                              subtitle: Text('Serviço: $servicoNome\nHorário: ${DateFormat('dd/MM/yyyy - HH:mm').format(agendamento.dataHora)}'),
                            );
                          }
                        },
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
