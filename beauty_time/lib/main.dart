import 'package:beauty_time/infrastructure/funcionario_sqlite_adapter.dart';
import 'package:beauty_time/interface_grafica/funcionario_list_screen.dart';
import 'package:beauty_time/interface_grafica/servico_list_screen.dart';
import 'package:beauty_time/view/agendamento_view.dart';
import 'package:beauty_time/view/cliente_view.dart';
import 'package:beauty_time/view/funcionario_view.dart';
import 'package:beauty_time/view/servico_view.dart';
import 'package:flutter/material.dart';

import 'infrastructure/agendamento_sqlite_adapter.dart';
import 'infrastructure/cliente_sqlite_adapter.dart';
import 'infrastructure/servico_sqlite_adapter.dart';
import 'infrastructure/sms_service.dart';
import 'interface_grafica/agendamento_list_screen.dart';
import 'interface_grafica/cliente_list_screen.dart';
import 'interface_grafica/home_screen.dart';

void main() {
  runApp(MyFlutterApp());
}

class MyFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var agendamentoRepository = AgendamentoSQLiteAdapter();
    var clienteRepository = ClienteSQLiteAdapter();
    var funcionarioRepository = FuncionarioSQLiteAdapter();
    var servicoRepository = ServicoSQLiteAdapter();
    var smsService = SMSServiceImpl();

    var agendamentoView = AgendamentoView(agendamentoRepository: agendamentoRepository, smsService: smsService);
    var clienteView = ClienteView(clienteRepository: clienteRepository);
    var funcionarioView = FuncionarioView(funcionarioRepository: funcionarioRepository);
    var servicoView = ServicoView(servicoRepository: servicoRepository);

    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
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
              title: Text('Agendamento'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AgendamentoListScreen(
                            agendamentoView: agendamentoView,
                            clienteView: clienteView,
                            funcionarioView: funcionarioView,
                            servicoView: servicoView,
                          )),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Clientes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClienteListScreen(
                            clienteView: clienteView,
                          )),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Funcionario'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FuncionarioListScreen(
                            funcionarioView: funcionarioView,
                          )),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Serviços'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ServicoListScreen(
                            servicoView: servicoView,
                          )),
                );
              },
            ),
          ],
        ),
      ),
      body: HomePage( // Aqui você chama a HomePage
        agendamentoView: agendamentoView,
        clienteView: clienteView,
        servicoView: servicoView,
      ),
    );
  }
}
