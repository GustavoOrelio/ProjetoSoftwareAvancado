import '../core-private/agendamento.dart';

abstract class AgendamentoRepository {
  Future<void> adicionarAgendamento(Agendamento agendamento);
  Future<void> removerAgendamento(int id);
  Future<List<Agendamento>> buscarAgendamentos();
  Future<void> atualizarAgendamento(Agendamento agendamento);
}