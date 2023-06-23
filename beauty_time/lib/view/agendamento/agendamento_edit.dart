import 'package:flutter/material.dart';

import '../../domain/dto/agendamento_dto.dart';

class AgendamentoEditScreen extends StatefulWidget {
  final AgendamentoDTO agendamento;

  AgendamentoEditScreen(this.agendamento);

  @override
  _AgendamentoEditScreenState createState() => _AgendamentoEditScreenState();
}

class _AgendamentoEditScreenState extends State<AgendamentoEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late AgendamentoDTO _agendamentoDTO;

  @override
  void initState() {
    super.initState();
    _agendamentoDTO = widget.agendamento;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Agendamento'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: _agendamentoDTO.id,
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
