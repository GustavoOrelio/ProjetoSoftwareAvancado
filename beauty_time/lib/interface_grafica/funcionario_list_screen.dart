import 'package:flutter/material.dart';

import '../domain/dto/funcionario_dto.dart';
import '../view/funcionario_view.dart';
import 'funcionario_screen.dart';

class FuncionarioListScreen extends StatefulWidget {
  final FuncionarioView funcionarioView;

  FuncionarioListScreen({required this.funcionarioView});

  @override
  _FuncionarioListScreenState createState() => _FuncionarioListScreenState();
}

class _FuncionarioListScreenState extends State<FuncionarioListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Funcionarios'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FuncionarioScreen(funcionarioView: widget.funcionarioView)),
              ).then((_) {
                setState(() {}); // Atualize a lista de funcionarios quando voltar.
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<FuncionarioDTO>>(
        future: widget.funcionarioView.obterTodosFuncionarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ocorreu um erro!'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(snapshot.data![i].nome),
                subtitle: Text(snapshot.data![i].cargo),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    widget.funcionarioView.removerFuncionario(snapshot.data![i].id);
                    setState(() {}); // Atualize a lista de funcionarios.
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
