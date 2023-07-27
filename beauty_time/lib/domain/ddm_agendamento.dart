import 'package:beauty_time/domain/dto/agendamento_dto.dart';
import 'package:beauty_time/domain/porta/i_agendamento.dart';
import 'package:beauty_time/domain/porta/i_sms_service.dart';
import 'package:uuid/uuid.dart';

import 'core-private/agendamento.dart';

class AgendamentoCreator {
  final AgendamentoRepository agendamentoRepository;
  final ISmsService smsService;

  AgendamentoCreator(
      {required this.smsService, required this.agendamentoRepository});

  Future<void> createAgendamento(String clienteId, String funcionarioId,
      String servicoId, DateTime dataHora) async {
    try {
      var agendamento = Agendamento(
          id: Uuid().v4(),
          clienteId: clienteId,
          funcionarioId: funcionarioId,
          servicoId: servicoId,
          dataHora: dataHora,
          smsService: smsService);
      await agendamentoRepository
          .adicionarAgendamento(agendamento as AgendamentoDTO);
    } catch (e) {
      print('Erro ao criar agendamento: $e');
    }
  }
}
