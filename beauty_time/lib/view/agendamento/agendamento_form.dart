import 'package:flutter/material.dart';

import '../../domain/dto/agendamento_dto.dart';

class AgendamentoFormScreen extends StatefulWidget {
  @override
  _AgendamentoFormScreenState createState() => _AgendamentoFormScreenState();
}

class _AgendamentoFormScreenState extends State<AgendamentoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _agendamentoDTO = AgendamentoDTO(id: '', dataHora: DateTime.now(), clienteId: '', funcionarioId: '', servicoId: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Agendamento'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'ID'),
              onSaved: (value) {
                _agendamentoDTO.id = value ?? '';
              },
            ),
            // Adicione mais campos aqui...
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          _formKey.currentState?.save();
          Navigator.of(context).pop(_agendamentoDTO);
        },
      ),
    );
  }
}
