import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../domain/dto/agendamento_dto.dart';
import '../domain/porta/i_agendamento.dart';

class AgendamentoSQLiteAdapter implements AgendamentoRepository {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'agendamentos.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE agendamentos(id TEXT PRIMARY KEY, clienteId TEXT, funcionarioId TEXT, servicoId TEXT, dataHora TEXT)",
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> adicionarAgendamento(AgendamentoDTO agendamento) async {
    final db = await database;

    await db.insert(
      'agendamentos',
      agendamento.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removerAgendamento(String id) async {
    final db = await database;

    await db.delete(
      'agendamentos',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<List<AgendamentoDTO>> obterTodosAgendamentos() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('agendamentos');

    return List.generate(maps.length, (i) {
      return AgendamentoDTO.fromMap(maps[i]);
    });
  }
}
