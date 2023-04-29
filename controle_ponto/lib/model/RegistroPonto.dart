import 'package:controle_ponto/interface/IRegistroPonto.dart';
import 'package:controle_ponto/model/Funcionario.dart';

class RegistroPonto implements IRegistroPonto {
  DateTime? entrada;
  DateTime? saida;
  DateTime? intervaloAlmocoInicio;
  DateTime? intervaloAlmocoFim;
  late final Funcionario funcionario;

  void registrarEntrada(DateTime entrada) {
    if (isFinalDeSemana(entrada)) {
      throw Exception('Não é permitido registrar ponto nos finais de semana.');
    }
    this.entrada = entrada;
  }

  void registrarSaida(DateTime saida) {
    if (isFinalDeSemana(saida)) {
      throw Exception('Não é permitido registrar ponto nos finais de semana.');
    }
    if (entrada == null) {
      throw Exception("Entrada não registrada.");
    }
    this.saida = saida;
  }

  void registrarIntervaloAlmocoInicio(DateTime intervaloAlmocoInicio) {
    if (entrada == null) {
      throw Exception("Entrada não registrada.");
    }
    this.intervaloAlmocoInicio = intervaloAlmocoInicio;
  }

  void registrarIntervaloAlmocoFim(DateTime intervaloAlmocoFim) {
    if (intervaloAlmocoInicio == null) {
      throw Exception("Intervalo de almoço não registrado.");
    }
    this.intervaloAlmocoFim = intervaloAlmocoFim;
  }

  Duration tempoIntervaloAlmoco() {
    if (intervaloAlmocoInicio == null || intervaloAlmocoFim == null) {
      throw Exception("Intervalo de almoço não registrado.");
    }
    return intervaloAlmocoFim!.difference(intervaloAlmocoInicio!);
  }

  bool horarioTrabalhoMinimo() {
    if (entrada == null ||
        saida == null ||
        intervaloAlmocoInicio == null ||
        intervaloAlmocoFim == null) {
      throw Exception(
          "Informações insuficientes para validar o horário de trabalho mínimo.");
    }

    Duration duracaoTrabalho = saida!.difference(entrada!);
    Duration duracaoAlmoco =
        intervaloAlmocoFim!.difference(intervaloAlmocoInicio!);
    Duration tempoTrabalhado = duracaoTrabalho - duracaoAlmoco;

    return tempoTrabalhado >= Duration(hours: 8);
  }

  bool possuiDuracaoTurnoValida() {
    if (entrada == null ||
        saida == null ||
        intervaloAlmocoInicio == null ||
        intervaloAlmocoFim == null) {
      throw Exception(
          "Informações insuficientes para validar a duração do turno.");
    }

    Duration duracaoTurnoManha = intervaloAlmocoInicio!.difference(entrada!);
    Duration duracaoTurnoTarde = saida!.difference(intervaloAlmocoFim!);

    return duracaoTurnoManha >= Duration(hours: 3) &&
        duracaoTurnoManha <= Duration(hours: 5) &&
        duracaoTurnoTarde >= Duration(hours: 3) &&
        duracaoTurnoTarde <= Duration(hours: 5);
  }

  bool possuiIntervaloMinimoEntreDias(RegistroPonto outroRegistro) {
    if (saida == null || outroRegistro.entrada == null) {
      throw Exception(
          "Informações insuficientes para validar o intervalo entre dias.");
    }

    Duration intervalo = outroRegistro.entrada!.difference(saida!);

    return intervalo >= Duration(hours: 12);
  }

  Duration horasExtrasDiarias() {
    if (saida == null ||
        entrada == null ||
        intervaloAlmocoInicio == null ||
        intervaloAlmocoFim == null) {
      throw Exception("Informações insuficientes para calcular horas extras.");
    }

    Duration jornadaTrabalho = Duration(hours: 8);
    Duration trabalhoRealizado = (saida!.difference(entrada!) -
        intervaloAlmocoFim!.difference(intervaloAlmocoInicio!));

    if (trabalhoRealizado > jornadaTrabalho) {
      return trabalhoRealizado - jornadaTrabalho;
    } else {
      return Duration();
    }
  }

  bool excedeuLimiteHorasExtrasDiarias() {
    Duration limiteHorasExtrasDiarias = Duration(hours: 2);
    Duration horasExtras = horasExtrasDiarias();

    return horasExtras > limiteHorasExtrasDiarias;
  }

  bool isFinalDeSemana(DateTime data) {
    int diaSemana = data.weekday;
    return diaSemana == DateTime.saturday || diaSemana == DateTime.sunday;
  }

  void reajustarPonto(Funcionario funcionario, DateTime novaEntrada, DateTime novaSaida) {
    if (funcionario.cargo.descricao != 'Gerente') {
      throw Exception('Somente um gerente pode realizar o reajuste dos pontos.');
    }
    entrada = novaEntrada;
    saida = novaSaida;
  }

  bool notificarFuncionario(Funcionario funcionario) {
    if (entrada == null || saida == null) {
      return false;
    }

    Duration duracaoTrabalhada = saida!.difference(entrada!) - tempoIntervaloAlmoco();
    Duration limiteHorasPermitidas = Duration(hours: 8);

    Duration tempoParaNotificacao = Duration(minutes: 30);

    if (duracaoTrabalhada >= limiteHorasPermitidas - tempoParaNotificacao) {
      return true;
    }
    return false;
  }
}
