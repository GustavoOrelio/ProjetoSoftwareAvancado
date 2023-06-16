import 'package:beauty_time/domain/dto/funcionario_dto.dart';
import 'package:beauty_time/domain/porta/i_funcionario.dart';
import 'package:flutter/material.dart';

class DetalhesFuncionarioPage extends StatefulWidget {
  final FuncionarioRepository funcionarioRepository;
  final FuncionarioDTO funcionario;

  DetalhesFuncionarioPage({
    Key? key,
    required this.funcionarioRepository,
    required this.funcionario,
  }) : super(key: key);

  @override
  _DetalhesFuncionarioPageState createState() => _DetalhesFuncionarioPageState();
}

class _DetalhesFuncionarioPageState extends State<DetalhesFuncionarioPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.funcionario.nome;
    _telefoneController.text = widget.funcionario.telefone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Funcionario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
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
                      const SnackBar(content: Text('Processando dados...')),
                    );
                    await widget.funcionarioRepository.updateFuncionario(
                      FuncionarioDTO(
                        id: widget.funcionario.id,
                        nome: _nomeController.text,
                        telefone: _telefoneController.text,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
