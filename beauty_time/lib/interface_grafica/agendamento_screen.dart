import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  Future<void> _selecionarDataHora() async {
    final DateTime? dataEscolhida = await showDatePicker(
      context: context,
      initialDate: dataHora,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (dataEscolhida != null) {
      final TimeOfDay? horaEscolhida = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(dataHora),
      );

      if (horaEscolhida != null) {
        setState(() {
          dataHora = DateTime(
            dataEscolhida.year,
            dataEscolhida.month,
            dataEscolhida.day,
            horaEscolhida.hour,
            horaEscolhida.minute,
          );
        });
      }
    }
  }

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
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Cliente'),
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
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Funcionário'),
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
                  final realFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Serviço'),
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
                        child: Text('${servico.nome} - ${realFormat.format(servico.preco)}'),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Data e hora',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _selecionarDataHora,
                ),
              ),
              controller: TextEditingController(
                text: DateFormat('dd/MM/yyyy - HH:mm').format(dataHora),
              ),
              readOnly: true,
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