import 'agendamento.dart';

class Funcionario {
  final int id;
  final String nome;
  final String telefone;
  final String email;
  List<Agendamento> agendamentos;

  Funcionario({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.email,
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

