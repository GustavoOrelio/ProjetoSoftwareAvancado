class Agendamento {
  final String id;
  final String clienteId;
  final String funcionarioId;
  final String servicoId;
  final DateTime dataHora;

  Agendamento({
    required this.id,
    required this.clienteId,
    required this.funcionarioId,
    required this.servicoId,
    required this.dataHora,
  }) {
    // Regra de negócio 1: A data e hora do agendamento devem ser no futuro.
    if (dataHora.isBefore(DateTime.now())) {
      throw Exception('A data e hora do agendamento devem ser no futuro.');
    }

    // Regra de negócio 2: O ID do cliente, funcionário e serviço não devem ser vazios.
    if (clienteId.isEmpty || funcionarioId.isEmpty || servicoId.isEmpty) {
      throw Exception(
          'O ID do cliente, funcionário e serviço não devem ser vazios.');
    }

    // Regra de negócio 3: A data do agendamento não pode ser um feriado.
    if (isHoliday(dataHora)) {
      throw Exception('A data do agendamento não pode ser um feriado.');
    }

    // Regra de negócio 4: A data do agendamento deve ser durante o horário de funcionamento do salão.
    if (!isBusinessHours(dataHora)) {
      throw Exception(
          'A data do agendamento deve ser durante o horário de funcionamento do salão.');
    }
  }

  bool isHoliday(DateTime date) {
    // Por exemplo, vamos supor que o salão está fechado no Natal.
    DateTime natal = DateTime(date.year, 12, 25);
    return date.day == natal.day && date.month == natal.month;
  }

  bool isBusinessHours(DateTime date) {
    // Por exemplo, vamos supor que o salão está aberto das 9h às 17h.
    int hour = date.hour;
    return hour >= 9 && hour < 17;
  }
}
