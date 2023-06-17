import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../domain/dto/agendamento_dto.dart';
import '../domain/porta/i_agendamento.dart';

class AgendamentoRepository implements IAgendamentoRepository {
  late Database _database;

  AgendamentoRepository() {
    initDB();
  }

  Future<void> initDB() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'agendamento.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE agendamentos(id INTEGER PRIMARY KEY, clienteId INTEGER, funcionarioId INTEGER, servicoId INTEGER, dataHora TEXT)",
        );
      },
      version: 1,
    );
  }

  @override
  Future<int> createAgendamento(AgendamentoDTO agendamento) async {
    return _database.insert(
      'agendamentos',
      agendamento.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<AgendamentoDTO>> fetchAgendamentos() async {
    final List<Map<String, dynamic>> maps = await _database.query('agendamentos');

    return List.generate(maps.length, (i) {
      return AgendamentoDTO.fromMap(maps[i]);
    });
  }

  @override
  Future<void> updateAgendamento(AgendamentoDTO agendamento) async {
    await _database.update(
      'agendamentos',
      agendamento.toMap(),
      where: "id = ?",
      whereArgs: [agendamento.id],
    );
  }

  @override
  Future<void> deleteAgendamento(int id) async {
    await _database.delete(
      'agendamentos',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
