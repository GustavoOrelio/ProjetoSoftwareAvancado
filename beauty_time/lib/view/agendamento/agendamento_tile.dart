import 'package:flutter/material.dart';

import '../../domain/dto/agendamento_dto.dart';
import '../../infrastructure/dao_agendamento.dart';

class AgendamentoTile extends StatelessWidget {
  final AgendamentoDTO agendamento;
  final AgendamentoRepository agendamentoRepository;

  AgendamentoTile(this.agendamento, this.agendamentoRepository);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(agendamento.clienteId),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              // Edita o agendamento
              // AgendamentoDTO editado = await Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AgendamentoEditScreen()),
              // );
              // if (editado != null) {
              //   agendamentoRepository.updateAgendamento(editado);
              //}
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Deleta o agendamento
              agendamentoRepository.deleteAgendamento(agendamento.id);
            },
          ),
        ],
      ),
    );
  }
}
