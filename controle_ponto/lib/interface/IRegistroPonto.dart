import '../model/Funcionario.dart';
import '../model/RegistroPonto.dart';

abstract class IRegistroPonto{
  void registrarEntrada(DateTime entrada);

  void registrarSaida(DateTime saida);

  void registrarIntervaloAlmocoInicio(DateTime intervaloAlmocoInicio);

  void registrarIntervaloAlmocoFim(DateTime intervaloAlmocoFim);

  Duration tempoIntervaloAlmoco();

  bool horarioTrabalhoMinimo();

  bool possuiDuracaoTurnoValida();

  bool possuiIntervaloMinimoEntreDias(RegistroPonto outroRegistro);

  Duration horasExtrasDiarias();

  bool excedeuLimiteHorasExtrasDiarias();

  bool isFinalDeSemana(DateTime data);

  void reajustarPonto(Funcionario funcionario, DateTime novaEntrada, DateTime novaSaida);

  bool notificarFuncionario(Funcionario funcionario);
}