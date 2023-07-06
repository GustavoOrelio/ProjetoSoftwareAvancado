import 'package:uuid/uuid.dart';

import '../domain/dto/agendamento_dto.dart';
import '../domain/porta/i_agendamento.dart';

class AgendamentoView {
  final AgendamentoRepository agendamentoRepository;
  final Uuid uuid;

  AgendamentoView({required this.agendamentoRepository}) : uuid = Uuid();

  Future<void> adicionarAgendamento(String clienteId, String funcionarioId,
      String servicoId, DateTime dataHora) async {
    var agendamento = AgendamentoDTO(
        id: uuid.v4(),
        clienteId: clienteId,
        funcionarioId: funcionarioId,
        servicoId: servicoId,
        dataHora: dataHora);
    await agendamentoRepository.adicionarAgendamento(agendamento);
  }

  Future<void> removerAgendamento(String id) async {
    await agendamentoRepository.removerAgendamento(id);
  }

  Future<List<AgendamentoDTO>> obterTodosAgendamentos() async {
    return await agendamentoRepository.obterTodosAgendamentos();
  }
}
