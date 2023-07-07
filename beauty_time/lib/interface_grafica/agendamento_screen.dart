import 'package:flutter/material.dart';

import '../domain/dto/cliente_dto.dart';
import '../domain/dto/funcionario_dto.dart';
import '../domain/dto/servico_dto.dart';
import '../view/agendamento_view.dart';
import '../view/cliente_view.dart';
import '../view/funcionario_view.dart';
import '../view/servico_view.dart';

class AgendamentoScreen extends StatefulWidget {
  final AgendamentoView agendamentoView;
  final ClienteView clienteView;
  final FuncionarioView funcionarioView;
  final ServicoView servicoView;

  AgendamentoScreen({
    required this.agendamentoView,
    required this.clienteView,
    required this.funcionarioView,
    required this.servicoView,
  });

  @override
  _AgendamentoScreenState createState() => _AgendamentoScreenState();
}

class _AgendamentoScreenState extends State<AgendamentoScreen> {
  String? clienteId;
  String? funcionarioId;
  String? servicoId;
  DateTime dataHora = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendar Serviço'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder<List<ClienteDTO>>(
              future: widget.clienteView.obterTodosClientes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.error != null) {
                  return Text('Ocorreu um erro!');
                } else {
                  return DropdownButton<String>(
                    value: clienteId,
                    onChanged: (String? newValue) {
                      setState(() {
                        clienteId = newValue;
                      });
                    },
                    items: snapshot.data!
                        .map<DropdownMenuItem<String>>((ClienteDTO cliente) {
                      return DropdownMenuItem<String>(
                        value: cliente.id,
                        child: Text(cliente.nome),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            FutureBuilder<List<FuncionarioDTO>>(
              future: widget.funcionarioView.obterTodosFuncionarios(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.error != null) {
                  return Text('Ocorreu um erro!');
                } else {
                  return DropdownButton<String>(
                    value: funcionarioId,
                    onChanged: (String? newValue) {
                      setState(() {
                        funcionarioId = newValue;
                      });
                    },
                    items: snapshot.data!.map<DropdownMenuItem<String>>(
                        (FuncionarioDTO funcionario) {
                      return DropdownMenuItem<String>(
                        value: funcionario.id,
                        child: Text(funcionario.nome),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            // Servico Dropdown
            FutureBuilder<List<ServicoDTO>>(
              future: widget.servicoView.obterTodosServicos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.error != null) {
                  return Text('Ocorreu um erro!');
                } else {
                  return DropdownButton<String>(
                    value: servicoId,
                    onChanged: (String? newValue) {
                      setState(() {
                        servicoId = newValue;
                      });
                    },
                    items: snapshot.data!
                        .map<DropdownMenuItem<String>>((ServicoDTO servico) {
                      return DropdownMenuItem<String>(
                        value: servico.id,
                        child: Text(servico.nome),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            // Botão de Agendar
            ElevatedButton(
              child: Text('Agendar'),
              onPressed: () {
                if (clienteId != null &&
                    funcionarioId != null &&
                    servicoId != null) {
                  widget.agendamentoView.adicionarAgendamento(
                      clienteId!, funcionarioId!, servicoId!, dataHora);
                  Navigator.pop(context); // Volte para a AgendamentoListScreen.
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
