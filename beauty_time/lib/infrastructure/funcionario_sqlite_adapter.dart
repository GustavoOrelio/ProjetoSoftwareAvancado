import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../domain/dto/funcionario_dto.dart';
import '../domain/porta/i_funcionario.dart';

class FuncionarioSQLiteAdapter implements FuncionarioRepository {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'funcionarios.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE funcionarios(id TEXT PRIMARY KEY, nome TEXT, cargo TEXT)",
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> adicionarFuncionario(FuncionarioDTO funcionario) async {
    final db = await database;

    await db.insert(
      'funcionarios',
      funcionario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removerFuncionario(String id) async {
    final db = await database;

    await db.delete(
      'funcionarios',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<List<FuncionarioDTO>> obterTodosFuncionarios() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('funcionarios');

    return List.generate(maps.length, (i) {
      return FuncionarioDTO.fromMap(maps[i]);
    });
  }
}
