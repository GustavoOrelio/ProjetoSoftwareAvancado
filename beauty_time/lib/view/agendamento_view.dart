import 'package:uuid/uuid.dart';

import '../domain/core-private/agendamento.dart';
import '../domain/dto/agendamento_dto.dart';
import '../domain/porta/i_agendamento.dart';
import '../domain/porta/i_sms.dart';
import '../domain/porta/i_sms_service.dart';
import '../infrastructure/cliente_sqlite_adapter.dart';
import 'package:intl/intl.dart';

class AgendamentoView {
  final AgendamentoRepository agendamentoRepository;

  //final SMSService smsService;
  final ISmsService smsService;
  final Uuid uuid;

  var clienteRepository = ClienteSQLiteAdapter();

  AgendamentoView(
      {required this.agendamentoRepository, required this.smsService})
      : uuid = Uuid();

  Future<void> adicionarAgendamento(String clienteId, String funcionarioId,
      String servicoId, DateTime dataHora) async {
    var agendamento = Agendamento(
        id: Uuid().v4(),
        clienteId: clienteId,
        funcionarioId: funcionarioId,
        servicoId: servicoId,
        dataHora: dataHora,
        smsService: smsService);
    await agendamentoRepository
        .adicionarAgendamento(agendamento as AgendamentoDTO);
    await agendamento.enviarNotificacao();
  }

  Future<void> removerAgendamento(String id) async {
    await agendamentoRepository.removerAgendamento(id);
  }

  Future<List<AgendamentoDTO>> obterTodosAgendamentos() async {
    return await agendamentoRepository.obterTodosAgendamentos();
  }
}
