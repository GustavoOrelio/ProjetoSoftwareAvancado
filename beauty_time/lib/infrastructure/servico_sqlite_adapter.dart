import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../domain/dto/servico_dto.dart';
import '../domain/porta/i_servico.dart';

class ServicoSQLiteAdapter implements ServicoRepository {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'servicos.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE servicos(id TEXT PRIMARY KEY, nome TEXT, preco REAL)",
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> adicionarServico(ServicoDTO servico) async {
    final db = await database;

    await db.insert(
      'servicos',
      servico.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removerServico(String id) async {
    final db = await database;

    await db.delete(
      'servicos',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<List<ServicoDTO>> obterTodosServicos() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('servicos');

    return List.generate(maps.length, (i) {
      return ServicoDTO.fromMap(maps[i]);
    });
  }
}
