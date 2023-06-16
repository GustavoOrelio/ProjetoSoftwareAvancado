import 'package:beauty_time/domain/dto/servico_dto.dart';
import 'package:beauty_time/domain/porta/i_servico.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ServicoDAO implements ServicoRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'servico.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE servicos(id INTEGER PRIMARY KEY, nome TEXT, valor TEXT)",
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> saveServico(ServicoDTO servico) async {
    final db = await database;

    await db.insert(
      'servicos',
      servico.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<ServicoDTO>> getServicos() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('servicos');

    return List.generate(maps.length, (i) {
      return ServicoDTO(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        valor: maps[i]['valor'],
      );
    });
  }

  @override
  Future<ServicoDTO> getServico(int id) async {
    final db = await database;

    List<Map<String, dynamic>> maps = await db.query(
      'servicos',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ServicoDTO(
        id: maps[0]['id'],
        nome: maps[0]['nome'],
        valor: maps[0]['valor'],
      );
    } else {
      throw Exception('ID $id não encontrado');
    }
  }

  @override
  Future<void> updateServico(ServicoDTO servico) async {
    final db = await database;

    await db.update(
      'servicos',
      servico.toMap(),
      where: "id = ?",
      whereArgs: [servico.id],
    );
  }

  @override
  Future<void> deleteServico(int id) async {
    final db = await database;

    await db.delete(
      'servicos',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
