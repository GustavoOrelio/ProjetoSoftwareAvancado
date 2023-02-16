import 'package:flutter/material.dart';

Widget CampoCpf(BuildContext context) {
  return const TextField(
    decoration: InputDecoration(
      label: Text('CPF'),
      hintText: 'Informe o CPF',
    ),
  );
}
