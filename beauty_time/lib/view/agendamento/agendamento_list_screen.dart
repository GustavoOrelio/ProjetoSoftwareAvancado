import 'package:flutter/material.dart';

import '../../domain/dto/agendamento_dto.dart';
import '../../infrastructure/dao_agendamento.dart';
import 'agendamento_form.dart';
import 'agendamento_tile.dart';

class AgendamentoListScreen extends StatefulWidget {
  @override
  _AgendamentoListScreenState createState() => _AgendamentoListScreenState();
}

class _AgendamentoListScreenState extends State<AgendamentoListScreen> {
  final AgendamentoRepository _agendamentoRepository = AgendamentoRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamentos'),
      ),
      body: FutureBuilder<List<AgendamentoDTO>>(
        future: _agendamentoRepository.findAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ocorreu um erro ao carregar os agendamentos.'));
          }

          final agendamentos = snapshot.data ?? [];
          return ListView.builder(
            itemCount: agendamentos.length,
            itemBuilder: (ctx, i) => AgendamentoTile(agendamentos[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var novoAgendamento = await Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => AgendamentoFormScreen()),
          );
          if (novoAgendamento != null) {
            await _agendamentoRepository.createAgendamento(novoAgendamento);
            setState(() {});
          }
        },
      ),
    );
  }
}