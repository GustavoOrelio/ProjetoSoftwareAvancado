enum TipoRegistroPonto {
  ENTRADA,
  SAIDA,
  ALMOCO_INICIO,
  ALMOCO_FIM,
}

abstract class Colaborador {
  String get nome;

  List<RegistroPonto> get registros;

  void registrarPonto(TipoRegistroPonto tipo);

  bool isProximoLimiteHoras(int limite);
}

class RegistroPonto {
  final TipoRegistroPonto tipo;
  final DateTime horario;

  RegistroPonto({required this.tipo, required this.horario});

  static RegistroPonto criar(TipoRegistroPonto tipo, DateTime horario) {
    switch (tipo) {
      case TipoRegistroPonto.ENTRADA:
        return Entrada(horario: horario);
      case TipoRegistroPonto.SAIDA:
        return Saida(horario: horario);
      case TipoRegistroPonto.ALMOCO_INICIO:
        return AlmocoInicio(horario: horario);
      case TipoRegistroPonto.ALMOCO_FIM:
        return AlmocoFim(horario: horario);
    }
  }
}

class Entrada extends RegistroPonto {
  Entrada({required DateTime horario})
      : super(tipo: TipoRegistroPonto.ENTRADA, horario: horario);
}

class Saida extends RegistroPonto {
  Saida({required DateTime horario})
      : super(tipo: TipoRegistroPonto.SAIDA, horario: horario);
}

class AlmocoInicio extends RegistroPonto {
  AlmocoInicio({required DateTime horario})
      : super(tipo: TipoRegistroPonto.ALMOCO_INICIO, horario: horario);
}

class AlmocoFim extends RegistroPonto {
  AlmocoFim({required DateTime horario})
      : super(tipo: TipoRegistroPonto.ALMOCO_FIM, horario: horario);
}

abstract class ValidacaoRegistro {
  bool validarRegistro(
      TipoRegistroPonto tipo, DateTime horario, List<RegistroPonto> registros);
}

class MockValidacaoRegistro implements ValidacaoRegistro {
  @override
  bool validarRegistro(
      TipoRegistroPonto tipo, DateTime horario, List<RegistroPonto> registros) {
    return true; // Simula que a validação passou
  }
}

class Funcionario implements Colaborador {
  final String nome;
  final List<RegistroPonto> registros = [];

  Funcionario({required this.nome});

  @override
  void registrarPonto(TipoRegistroPonto tipo) {
    final horarioAtual = DateTime.now();
    registros.add(RegistroPonto.criar(tipo, horarioAtual));
  }

  @override
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
}

class ValidationException implements Exception {
  final String message;

  ValidationException(this.message);
}

class ValidacaoRegistroFuncionario implements ValidacaoRegistro {
  @override
  bool validarRegistro(
      TipoRegistroPonto tipo, DateTime horario, List<RegistroPonto> registros) {
    // Implementar as validações específicas do funcionário
    // Exemplo: Verifica se já existe um registro do mesmo tipo no mesmo dia
    return registros.every((r) => r.tipo != tipo || !isSameDay(r.horario, horario));
  }

  bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}