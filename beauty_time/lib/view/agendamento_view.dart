import 'package:uuid/uuid.dart';

import '../domain/dto/agendamento_dto.dart';
import '../domain/porta/i_agendamento.dart';
import '../domain/porta/i_sms.dart';
import '../infrastructure/cliente_sqlite_adapter.dart';
import 'package:intl/intl.dart';

class AgendamentoView {
  final AgendamentoRepository agendamentoRepository;
  final SMSService smsService;
  final Uuid uuid;

  var clienteRepository = ClienteSQLiteAdapter();

  AgendamentoView(
      {required this.agendamentoRepository, required this.smsService})
      : uuid = Uuid();

  Future<void> adicionarAgendamento(String clienteId, String funcionarioId,
      String servicoId, DateTime dataHora) async {
    var agendamento = AgendamentoDTO(
        id: Uuid().v4(),
        clienteId: clienteId,
        funcionarioId: funcionarioId,
        servicoId: servicoId,
        dataHora: dataHora);
    await agendamentoRepository.adicionarAgendamento(agendamento);

    // Enviar SMS ao cliente
    var cliente = await clienteRepository.obterClientePorId(clienteId);
    var format = DateFormat('HH:mm - dd/MM/yyyy');
    var mensagem =
        'Seu agendamento foi marcado para ${format.format(dataHora)}';
    await smsService.enviarSMS(cliente.telefone, mensagem);
  }

  Future<void> removerAgendamento(String id) async {
    await agendamentoRepository.removerAgendamento(id);
  }

  Future<List<AgendamentoDTO>> obterTodosAgendamentos() async {
    return await agendamentoRepository.obterTodosAgendamentos();
  }
}
