import 'package:flutter/material.dart';

Widget BotaoVerificar(BuildContext context) {
  return ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ValidarCpf(context);
            });
      },
      child: const Text('OK'));
}

Widget ValidarCpf(BuildContext context) {
  return const AlertDialog(
    title: Text('Resultado'),
    content: Text('CPF correto'),
  );
}
