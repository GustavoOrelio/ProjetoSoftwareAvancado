enum TipoRegistroPonto {
  ENTRADA,
  SAIDA,
  ALMOCO_INICIO,
  ALMOCO_FIM,
}

class RegistroPonto {
  final TipoRegistroPonto tipo;
  final DateTime horario;

  RegistroPonto({required this.tipo, required this.horario});
}

class Funcionario {
  final String nome;
  final List<RegistroPonto> registros = [];

  Funcionario({required this.nome});

  void registrarPonto(TipoRegistroPonto tipo) {
    final horarioAtual = DateTime.now();
    final ultimoRegistro = registros.isNotEmpty ? registros.last : null;

    if (ultimoRegistro != null && ultimoRegistro.tipo == tipo) {
      throw Exception(
          'Você já registrou um(a) ${tipo.toString().split('.')[1]} hoje.');
    }

    if (tipo == TipoRegistroPonto.ALMOCO_INICIO) {
      if (ultimoRegistro == null ||
          ultimoRegistro.tipo != TipoRegistroPonto.ENTRADA) {
        throw Exception(
            'Você precisa registrar a entrada antes de registrar o início do almoço.');
      }

      final tempoTrabalho = horarioAtual.difference(ultimoRegistro.horario);
      if (tempoTrabalho.inHours < 3 || tempoTrabalho.inHours > 5) {
        throw Exception(
            'O turno deve ter no mínimo 3 horas e no máximo 5 horas.');
      }
    }

    if (tipo == TipoRegistroPonto.ALMOCO_FIM) {
      if (ultimoRegistro == null ||
          ultimoRegistro.tipo != TipoRegistroPonto.ALMOCO_INICIO) {
        throw Exception(
            'Você precisa registrar o início do almoço antes de registrar o fim do almoço.');
      }

      final tempoAlmoco = horarioAtual.difference(ultimoRegistro.horario);
      if (tempoAlmoco.inHours != 1) {
        throw Exception('O almoço deve ter 1 hora de duração.');
      }
    }

    if (tipo == TipoRegistroPonto.SAIDA) {
      if (ultimoRegistro == null ||
          ultimoRegistro.tipo != TipoRegistroPonto.ALMOCO_FIM) {
        throw Exception(
            'Você precisa registrar o fim do almoço antes de registrar a saída.');
      }

      final horarioEntrada = registros
          .firstWhere((r) => r.tipo == TipoRegistroPonto.ENTRADA)
          .horario;
      final tempoTrabalho = horarioAtual.difference(horarioEntrada);

      if (tempoTrabalho.inHours < 8) {
        throw Exception('Você precisa trabalhar pelo menos 8 horas por dia.');
      }

      final tempoExtra = tempoTrabalho.inHours - 8;
      if (tempoExtra > 0) {
        throw Exception('Você já trabalhou $tempoExtra hora(s) extra(s) hoje.');
      }

      if (horarioAtual.weekday == DateTime.saturday ||
          horarioAtual.weekday == DateTime.sunday) {
        throw Exception(
            'Não é permitido registrar ponto aos finais de semana.');
      }
    }

    if (ultimoRegistro != null &&
        horarioAtual.difference(ultimoRegistro.horario).inHours < 12) {
      throw Exception(
          'O interstício de trabalho de um dia para o outro deve ser de no mínimo 12 horas.');
    }

    registros.add(RegistroPonto(tipo: tipo, horario: horarioAtual));
  }

  bool isProximoLimiteHoras(int limite) {
    final hoje = DateTime.now();
    final inicioSemana = hoje.subtract(Duration(days: hoje.weekday - 1));
    final registrosSemana =
        registros.where((r) => r.horario.isAfter(inicioSemana));

    final totalHorasDia = {
      for (var r
          in registrosSemana.where((r) => r.tipo == TipoRegistroPonto.SAIDA))
        DateTime(r.horario.year, r.horario.month, r.horario.day): r.horario
            .difference(
              registrosSemana
                  .firstWhere(
                    (r2) =>
                        r2.horario.isBefore(r.horario) &&
                        r2.tipo == TipoRegistroPonto.ENTRADA,
                  )
                  .horario,
            )
            .inHours
    };

    final totalHorasSemanais = totalHorasDia.values.reduce((a, b) => a + b);
    final totalHorasMensais =
        registrosSemana.where((r) => r.tipo == TipoRegistroPonto.SAIDA).length *
            8;

    final horasExtrasDiarias =
        totalHorasDia[hoje] != null ? totalHorasDia[hoje]! - 8 : 0;
    final horasExtrasSemanais = totalHorasSemanais - (8 * 5);
    final horasExtrasMensais = totalHorasMensais - (8 * 15);

    if (horasExtrasDiarias >= (limite - 2)) {
      return true;
    }

    if (horasExtrasSemanais >= (8 - 2)) {
      return true;
    }

    if (horasExtrasMensais >= (8 * 15 - 2)) {
      return true;
    }
    return false;
  }

  void solicitarAbonoHorasFaltantes(String justificativa, DateTime data) {
// Implementação da análise pelo gerente
  }

  void autorizarHorasExtras() {
// Implementação da autorização pelo gerente
  }
}
