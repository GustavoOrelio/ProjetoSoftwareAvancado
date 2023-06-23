import 'cliente.dart';
import 'funcionario.dart';
import 'servico.dart';

class Agendamento {
  final int id;
  final Cliente cliente;
  final Funcionario funcionario;
  final Servico servico;
  DateTime dataHora;

  Agendamento({
    required this.id,
    required this.cliente,
    required this.funcionario,
    required this.servico,
    required this.dataHora,
  }) {
    if (!isHorarioComercial(dataHora)) {
      throw Exception('Agendamento deve ser dentro do horário comercial.');
    }

    if (!funcionario.estaDisponivelNoHorario(dataHora)) {
      throw Exception('Funcionário não está disponível no horário escolhido.');
    }

    if (!servico.estaDisponivelNoHorario(dataHora)) {
      throw Exception('Serviço não está disponível no horário escolhido.');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clienteId': cliente,
      'funcionarioId': funcionario,
      'servicoId': servico,
      'dataHora': dataHora.toString(),
    };
  }

  bool isHorarioComercial(DateTime dataHora) {
    int inicioHorarioComercial = 8;
    int fimHorarioComercial = 18;

    if (dataHora.weekday < 1 || dataHora.weekday > 5) {
      return false;
    }

    if (dataHora.hour < inicioHorarioComercial ||
        dataHora.hour > fimHorarioComercial) {
      return false;
    }

    return true;
  }
}
