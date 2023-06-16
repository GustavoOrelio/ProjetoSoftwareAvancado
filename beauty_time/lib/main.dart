import 'package:beauty_time/infrastructure/dao_cliente.dart';
import 'package:beauty_time/view/agendamento/agendamento_page.dart';
import 'package:beauty_time/view/cliente/lista_cliente.dart';
import 'package:beauty_time/view/funcionario/lista_funcionario.dart';
import 'package:flutter/material.dart';

import 'infrastructure/dao_funcionario.dart';

void main() {
  runApp(MyFlutterApp());
}

class MyFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Clientes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaClientesPage(clienteRepository: ClienteDAO())),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Agendamentos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgendamentosPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Funcionarios'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaFuncionariosPage(funcionarioRepository: FuncionarioDAO())),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Página Inicial'),
      ),
    );
  }
}
