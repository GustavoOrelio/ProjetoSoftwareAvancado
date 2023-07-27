import '../porta/i_sms_service.dart';

class Agendamento {
  final String id;
  final String clienteId;
  final String funcionarioId;
  final String servicoId;
  final DateTime dataHora;
  final ISmsService smsService;

  Agendamento({
    required this.smsService,
    required this.id,
    required this.clienteId,
    required this.funcionarioId,
    required this.servicoId,
    required this.dataHora,
  }) {
    _validarDataHora();
    _validarIds();
  }

  void _validarDataHora() {
    if (dataHora.isBefore(DateTime.now())) {
      throw Exception('A data e hora do agendamento devem ser no futuro.');
    }
    if (isHoliday(dataHora)) {
      throw Exception('A data do agendamento não pode ser um feriado.');
    }
    if (!isBusinessHours(dataHora)) {
      throw Exception(
          'A data do agendamento deve ser durante o horário de funcionamento do salão.');
    }
  }

  void _validarIds() {
    if (clienteId.isEmpty || funcionarioId.isEmpty || servicoId.isEmpty) {
      throw Exception(
          'O ID do cliente, funcionário e serviço não devem ser vazios.');
    }
  }

  bool isHoliday(DateTime date) {
    DateTime natal = DateTime(date.year, 12, 25);
    return date.day == natal.day && date.month == natal.month;
  }

  bool isBusinessHours(DateTime date) {
    int hour = date.hour;
    return hour >= 9 && hour < 17;
  }

  Future<void> enviarNotificacao() async {
    String mensagem = 'Seu agendamento foi marcado para $dataHora';
    await smsService.enviarSMS(clienteId, mensagem);
  }
}
