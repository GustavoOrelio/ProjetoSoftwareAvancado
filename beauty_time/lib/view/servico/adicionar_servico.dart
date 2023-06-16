import 'package:beauty_time/domain/dto/servico_dto.dart';
import 'package:beauty_time/domain/porta/i_servico.dart';
import 'package:flutter/material.dart';

class AdicionarServicoPage extends StatefulWidget {
  final ServicoRepository servicoRepository;

  AdicionarServicoPage({Key? key, required this.servicoRepository})
      : super(key: key);

  @override
  _AdicionarServicoPageState createState() => _AdicionarServicoPageState();
}

class _AdicionarServicoPageState extends State<AdicionarServicoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Servico'),
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
                controller: _valorController,
                decoration: InputDecoration(labelText: 'Valor'),
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
                      SnackBar(content: Text('Processando dados...')),
                    );
                    await widget.servicoRepository.saveServico(
                      ServicoDTO(
                        id: DateTime.now().millisecondsSinceEpoch,
                        nome: _nomeController.text,
                        valor: _valorController.text,
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
