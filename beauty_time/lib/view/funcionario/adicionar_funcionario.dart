import 'package:beauty_time/domain/dto/funcionario_dto.dart';
import 'package:beauty_time/domain/porta/i_funcionario.dart';
import 'package:flutter/material.dart';

class AdicionarFuncionarioPage extends StatefulWidget {
  final FuncionarioRepository funcionarioRepository;

  AdicionarFuncionarioPage({Key? key, required this.funcionarioRepository})
      : super(key: key);

  @override
  _AdicionarFuncionarioPageState createState() => _AdicionarFuncionarioPageState();
}

class _AdicionarFuncionarioPageState extends State<AdicionarFuncionarioPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Funcionario'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processando dados...')),
                    );
                    await widget.funcionarioRepository.saveFuncionario(
                      FuncionarioDTO(
                        id: DateTime.now().millisecondsSinceEpoch,
                        nome: _nomeController.text,
                        telefone: _telefoneController.text,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
