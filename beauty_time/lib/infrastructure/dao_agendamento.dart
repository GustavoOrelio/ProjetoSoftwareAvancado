import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../domain/core-private/agendamento.dart';
import '../domain/dto/agendamento_dto.dart';

class AgendamentoRepository {
  Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), 'beauty_time.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE agendamentos(id INTEGER PRIMARY KEY, clienteId INTEGER, funcionarioId INTEGER, servicoId INTEGER, dataHora TEXT)');
      },
      version: 1,
    );
  }

  Future<int> createAgendamento(Agendamento agendamento) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> agendamentoMap = agendamento.toMap();
    return db.insert('agendamentos', agendamentoMap);
  }

  Future<int> save(Agendamento agendamento) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> agendamentoMap = agendamento.toMap();
    return db.insert('agendamentos', agendamentoMap);
  }

  Future<List<AgendamentoDTO>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('agendamentos');
    List<AgendamentoDTO> agendamentos = _toList(result).cast<AgendamentoDTO>();
    return agendamentos;
  }

  List<Agendamento> _toList(List<Map<String, dynamic>> result) {
    final List<Agendamento> agendamentos = [];
    for (Map<String, dynamic> row in result) {
      final Agendamento agendamento = Agendamento(
          id: row['id'],
          cliente: row['clienteId'],
          funcionario: row['funcionarioId'],
          servico: row['servicoId'],
          dataHora: DateTime.parse(row['dataHora']),);
      agendamentos.add(agendamento);
    }
    return agendamentos;
  }

  Future<int> updateAgendamento(AgendamentoDTO agendamentoDTO) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> agendamentoMap = agendamentoDTO.toMap();
    return db.update('agendamentos', agendamentoMap, where: 'id = ?', whereArgs: [agendamentoDTO.id]);
  }

  Future<int> deleteAgendamento(int id) async {
    final Database db = await getDatabase();
    return db.delete('agendamentos', where: 'id = ?', whereArgs: [id]);
  }
}