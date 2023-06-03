import 'package:beauty_time/domain/dto/cliente_dto.dart';
import 'package:beauty_time/domain/porta/i_cliente.dart';
import 'package:flutter/material.dart';

class DetalhesClientePage extends StatefulWidget {
  final ClienteRepository clienteRepository;
  final ClienteDTO cliente;

  DetalhesClientePage({
    Key? key,
    required this.clienteRepository,
    required this.cliente,
  }) : super(key: key);

  @override
  _DetalhesClientePageState createState() => _DetalhesClientePageState();
}

class _DetalhesClientePageState extends State<DetalhesClientePage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.cliente.nome;
    _telefoneController.text = widget.cliente.telefone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Cliente'),
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
                    await widget.clienteRepository.updateCliente(
                      ClienteDTO(
                        id: widget.cliente.id,
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
