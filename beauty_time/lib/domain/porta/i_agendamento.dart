import '../dto/agendamento_dto.dart';

abstract class IAgendamentoRepository {
  Future<List<AgendamentoDTO>> fetchAgendamentos();
  Future<void> createAgendamento(AgendamentoDTO agendamentoDTO);
  Future<void> updateAgendamento(AgendamentoDTO agendamentoDTO);
  Future<void> deleteAgendamento(int id);
}