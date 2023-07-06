import 'package:beauty_time/view/cliente_view.dart';
import 'package:flutter/material.dart';

import 'infrastructure/cliente_sqlite_adapter.dart';
import 'interface_grafica/cliente_list_screen.dart';

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
    var clienteRepository = ClienteSQLiteAdapter();

    var clienteView = ClienteView(clienteRepository: clienteRepository);

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
          ],
        ),
      ),
      body: Center(
        child: Text('Página Inicial'),
      ),
    );
  }
}
