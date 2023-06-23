import 'package:flutter/material.dart';

import '../../domain/dto/agendamento_dto.dart';
import '../../infrastructure/dao_agendamento.dart';
import 'agendamento_edit.dart';

class AgendamentoTile extends StatelessWidget {
  final AgendamentoDTO agendamento;
  final AgendamentoRepository _agendamentoRepository = AgendamentoRepository();

  AgendamentoTile(this.agendamento);

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
              AgendamentoDTO editado = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AgendamentoEditScreen(agendamento)),
              );
              if (editado != null) {
                _agendamentoRepository.updateAgendamento(editado);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _agendamentoRepository.deleteAgendamento(int.parse(agendamento.id));
            },
          ),
        ],
      ),
    );
  }
}