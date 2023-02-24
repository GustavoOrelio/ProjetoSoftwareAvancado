import 'package:aula_16_02/components/validarCpf.dart';
import 'package:flutter/material.dart';

class ValidaCpf extends StatefulWidget {
  @override
  _FormularioCPFState createState() => _FormularioCPFState();
}

class _FormularioCPFState extends State<ValidaCpf> {
  final _formKey = GlobalKey<FormState>();
  late String _cpf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Validador de CPF'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Insira o CPF:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(hintText: '000.000.000-00'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, informe o CPF.';
                      } else if (!ValidarCPF(value!)) {
                        return 'CPF inválido.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _cpf = value!;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('CPF Válido'),
                              content: Text('O CPF $_cpf é válido.'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text('Validar CPF'),
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
