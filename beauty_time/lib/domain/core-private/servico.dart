import 'agendamento.dart';

class Servico {
  final int id;
  final String nome;
  final String valor;
  List<Agendamento> agendamentos;

  Servico({
    required this.id,
    required this.nome,
    required this.valor,
    required this.agendamentos,
  });

  bool estaDisponivelNoHorario(DateTime dataHora) {
    if (agendamentos == null || agendamentos.isEmpty) {
      return true;
    }

    for (Agendamento agendamento in agendamentos) {
      if (agendamento.dataHora.isAtSameMomentAs(dataHora)) {
        return false;
      }
    }

    return true;
  }
}
