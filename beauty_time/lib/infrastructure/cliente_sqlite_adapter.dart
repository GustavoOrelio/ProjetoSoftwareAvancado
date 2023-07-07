import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../domain/dto/cliente_dto.dart';
import '../domain/porta/i_cliente.dart';

class ClienteSQLiteAdapter implements ClienteRepository {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'clientes.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE clientes(id TEXT PRIMARY KEY, nome TEXT, telefone TEXT)",
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> adicionarCliente(ClienteDTO cliente) async {
    final db = await database;

    await db.insert(
      'clientes',
      cliente.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removerCliente(String id) async {
    final db = await database;

    await db.delete(
      'clientes',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<List<ClienteDTO>> obterTodosClientes() async {
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
  Future<ClienteDTO> obterClientePorId(String id) async {
    final db = await database;
    final maps = await db.query(
      'clientes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ClienteDTO.fromMap(maps.first);
    } else {
      throw Exception('Cliente não encontrado');
    }
  }
}
