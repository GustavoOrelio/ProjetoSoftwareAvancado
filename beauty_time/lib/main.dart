import 'package:flutter/material.dart';

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
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text(
      //           'Menu',
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 24,
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.account_circle),
      //         title: Text('Clientes'),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => AgendamentoListScreen()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.schedule),
      //         title: Text('Agendamentos'),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => AgendamentoListScreen()),
      //           );
      //         },
      //       ),
      //
      //       ListTile(
      //         leading: Icon(Icons.task),
      //         title: Text('Serviços'),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => ListaServicosPage(servicoRepository: ServicoDAO())),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: Center(
        child: Text('Página Inicial'),
      ),
    );
  }
}
