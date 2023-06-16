import 'package:beauty_time/domain/dto/servico_dto.dart';
import 'package:beauty_time/domain/porta/i_servico.dart';
import 'package:flutter/material.dart';

class DetalhesServicoPage extends StatefulWidget {
  final ServicoRepository servicoRepository;
  final ServicoDTO servico;

  DetalhesServicoPage({
    Key? key,
    required this.servicoRepository,
    required this.servico,
  }) : super(key: key);

  @override
  _DetalhesServicoPageState createState() => _DetalhesServicoPageState();
}

class _DetalhesServicoPageState extends State<DetalhesServicoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.servico.nome;
    _valorController.text = widget.servico.valor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Servico'),
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
                controller: _valorController,
                decoration: const InputDecoration(labelText: 'Valor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor';
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
                    await widget.servicoRepository.updateServico(
                      ServicoDTO(
                        id: widget.servico.id,
                        nome: _nomeController.text,
                        valor: _valorController.text,
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
