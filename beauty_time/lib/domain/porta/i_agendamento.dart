import '../dto/agendamento_dto.dart';

abstract class AgendamentoRepository {
  Future<void> adicionarAgendamento(AgendamentoDTO agendamento);

  Future<void> removerAgendamento(String id);

  Future<List<AgendamentoDTO>> obterTodosAgendamentos();
}
