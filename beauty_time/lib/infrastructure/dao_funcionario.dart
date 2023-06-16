import 'package:beauty_time/domain/dto/funcionario_dto.dart';
import 'package:beauty_time/domain/porta/i_funcionario.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FuncionarioDAO implements FuncionarioRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'funcionario.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE funcionarios(id INTEGER PRIMARY KEY, nome TEXT, telefone TEXT)",
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> saveFuncionario(FuncionarioDTO funcionario) async {
    final db = await database;

    await db.insert(
      'funcionarios',
      funcionario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<FuncionarioDTO>> getFuncionarios() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('funcionarios');

    return List.generate(maps.length, (i) {
      return FuncionarioDTO(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        telefone: maps[i]['telefone'],
      );
    });
  }

  @override
  Future<FuncionarioDTO> getFuncionario(int id) async {
    final db = await database;

    List<Map<String, dynamic>> maps = await db.query(
      'funcionarios',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return FuncionarioDTO(
        id: maps[0]['id'],
        nome: maps[0]['nome'],
        telefone: maps[0]['telefone'],
      );
    } else {
      throw Exception('ID $id não encontrado');
    }
  }

  @override
  Future<void> updateFuncionario(FuncionarioDTO funcionario) async {
    final db = await database;

    await db.update(
      'funcionarios',
      funcionario.toMap(),
      where: "id = ?",
      whereArgs: [funcionario.id],
    );
  }

  @override
  Future<void> deleteFuncionario(int id) async {
    final db = await database;

    await db.delete(
      'funcionarios',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
