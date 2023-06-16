import 'package:sqflite/sqflite.dart';
import '../domain/core-private/agendamento.dart';
import '../domain/porta/i_agendamento.dart';


class AgendamentoSqfliteRepository implements AgendamentoRepository {
  final Database database;

  AgendamentoSqfliteRepository(this.database);

  @override
  Future<void> adicionarAgendamento(Agendamento agendamento) async {
    await database.insert(
      'agendamentos',
      agendamento.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removerAgendamento(int id) async {
    await database.delete(
      'agendamentos',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<List<Agendamento>> buscarAgendamentos() async {
    final List<Map<String, dynamic>> maps = await database.query('agendamentos');

    return List.generate(maps.length, (i) {
      return Agendamento(
        id: maps[i]['id'],
        nomeCliente: maps[i]['nomeCliente'],
        nomeFuncionario: maps[i]['nomeFuncionario'],
        dataHora: DateTime.parse(maps[i]['dataHora']),
      );
    });
  }

  @override
  Future<void> atualizarAgendamento(Agendamento agendamento) async {
    await database.update(
      'agendamentos',
      agendamento.toMap(),
      where: "id = ?",
      whereArgs: [agendamento.id],
    );
  }
}