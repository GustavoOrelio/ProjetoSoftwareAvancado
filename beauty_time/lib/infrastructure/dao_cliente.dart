import 'package:beauty_time/domain/dto/cliente_dto.dart';
import 'package:beauty_time/domain/porta/i_cliente.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ClienteDAO implements ClienteRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'databasename.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE clientes(id INTEGER PRIMARY KEY, nome TEXT, telefone TEXT)",
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> saveCliente(ClienteDTO cliente) async {
    final db = await database;

    await db.insert(
      'clientes',
      cliente.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<ClienteDTO>> getClientes() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('clientes');

    return List.generate(maps.length, (i) {
      return ClienteDTO(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        telefone: maps[i]['telefone'],
      );
    });
  }

  @override
  Future<ClienteDTO> getCliente(int id) async {
    final db = await database;

    List<Map<String, dynamic>> maps = await db.query(
      'clientes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ClienteDTO(
        id: maps[0]['id'],
        nome: maps[0]['nome'],
        telefone: maps[0]['telefone'],
      );
    } else {
      throw Exception('ID $id não encontrado');
    }
  }

  @override
  Future<void> updateCliente(ClienteDTO cliente) async {
    final db = await database;

    await db.update(
      'clientes',
      cliente.toMap(),
      where: "id = ?",
      whereArgs: [cliente.id],
    );
  }

  @override
  Future<void> deleteCliente(int id) async {
    final db = await database;

    await db.delete(
      'clientes',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
