import 'package:controle_ponto/model/Cargo.dart';
import 'package:controle_ponto/model/Funcionario.dart';
import 'package:controle_ponto/model/RegistroPonto.dart';
import 'package:flutter_test/flutter_test.dart';

/*
1 - O registro de ponto deve consistir em entrada e saída com o devido horário
    (entrada e saída) de almoco de 1h. ***
2 - Todo funcionario deve possuir o horário de trabalho mínimo de 8 horas com
    o interstício de almoco de 1h. Os horário são flexível. ***
3 - Cada turno deve possuir na máximo 5 horas de trabalho e no mínimo 3 horas. ***
4 - O interstício de trabalho de um dia para o outro deve ser de no mínimo 12 horas. ***
5 - A quantidade de horas extras deve se de no máximo 2 horas diárias ***
6 - Final de semana não deve possuir registros.
7 - Somente o gerente poderá realizar o reajuste dos pontos.
8 - O funcionário deve ser notificado, quando estiver trabalhando próximo ao
    limite de horas permitidas.
9 - O funcionário poderá solicitar o abono de horas faltantes mediante
    justificativas que será analizado pelo gerente.
10 - O funcionario só poderá realizar horas extras mediante autorização do gerente.
*/

void main() {
  group('RegistroPonto', () {
    test('Deve registrar entrada e saída corretamente', () {
      RegistroPonto registro = RegistroPonto();
      registro.registrarEntrada(DateTime.parse("2023-04-28 08:00:00"));
      registro.registrarSaida(DateTime.parse("2023-04-28 18:00:00"));

      expect(registro.entrada, DateTime.parse("2023-04-28 08:00:00"));
      expect(registro.saida, DateTime.parse("2023-04-28 18:00:00"));
    });

    test('Deve ter intervalo de almoço de 1 hora', () {
      RegistroPonto registro = RegistroPonto();
      registro.registrarEntrada(DateTime.parse("2023-04-28 08:00:00"));
      registro.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-28 12:00:00"));
      registro.registrarIntervaloAlmocoFim(DateTime.parse("2023-04-28 13:00:00"));
      registro.registrarSaida(DateTime.parse("2023-04-28 18:00:00"));

      expect(registro.intervaloAlmocoInicio, DateTime.parse("2023-04-28 12:00:00"));
      expect(registro.intervaloAlmocoFim, DateTime.parse("2023-04-28 13:00:00"));
      expect(registro.tempoIntervaloAlmoco(), Duration(hours: 1));
    });

    test('Deve lançar exceção se entrada não for registrada', () {
      RegistroPonto registro = RegistroPonto();
      expect(() => registro.registrarSaida(DateTime.parse("2023-04-28 18:00:00")), throwsA(TypeMatcher<Exception>()));
    });

    test('Deve lançar exceção se entrada não for registrada antes de registrar o início do intervalo de almoço', () {
      RegistroPonto registro = RegistroPonto();
      expect(() => registro.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-28 12:00:00")), throwsA(TypeMatcher<Exception>()));
    });

    test('Deve lançar exceção se intervalo de almoço não for registrado', () {
      RegistroPonto registro = RegistroPonto();
      registro.registrarEntrada(DateTime.parse("2023-04-28 08:00:00"));
      registro.registrarSaida(DateTime.parse("2023-04-28 18:00:00"));
      expect(() => registro.tempoIntervaloAlmoco(), throwsA(TypeMatcher<Exception>()));
    });

    test('Deve verificar se o funcionário possui o horário de trabalho mínimo de 8 horas, incluindo o intervalo de almoço de 1 hora', () {
      RegistroPonto registro = RegistroPonto();
      registro.registrarEntrada(DateTime.parse("2023-04-28 08:00:00"));
      registro.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-28 12:00:00"));
      registro.registrarIntervaloAlmocoFim(DateTime.parse("2023-04-28 13:00:00"));
      registro.registrarSaida(DateTime.parse("2023-04-28 18:00:00"));

      expect(registro.horarioTrabalhoMinimo(), true);

      RegistroPonto registro2 = RegistroPonto();
      registro2.registrarEntrada(DateTime.parse("2023-04-28 09:00:00"));
      registro2.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-28 12:00:00"));
      registro2.registrarIntervaloAlmocoFim(DateTime.parse("2023-04-28 13:00:00"));
      registro2.registrarSaida(DateTime.parse("2023-04-28 17:00:00"));

      expect(registro2.horarioTrabalhoMinimo(), false);
    });

    test('Deve verificar se cada turno possui no máximo 5 horas de trabalho e no mínimo 3 horas', () {
      RegistroPonto registro = RegistroPonto();
      registro.registrarEntrada(DateTime.parse("2023-04-28 08:00:00"));
      registro.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-28 12:00:00"));
      registro.registrarIntervaloAlmocoFim(DateTime.parse("2023-04-28 13:00:00"));
      registro.registrarSaida(DateTime.parse("2023-04-28 18:00:00"));

      expect(registro.possuiDuracaoTurnoValida(), true);

      RegistroPonto registro2 = RegistroPonto();
      registro2.registrarEntrada(DateTime.parse("2023-04-28 07:00:00"));
      registro2.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-28 12:30:00"));
      registro2.registrarIntervaloAlmocoFim(DateTime.parse("2023-04-28 13:30:00"));
      registro2.registrarSaida(DateTime.parse("2023-04-28 19:00:00"));

      expect(registro2.possuiDuracaoTurnoValida(), false);
    });

    test('Deve verificar se o intervalo entre os dias de trabalho é de no mínimo 12 horas', () {
      RegistroPonto registro1 = RegistroPonto();
      registro1.registrarEntrada(DateTime.parse("2023-04-27 08:00:00"));
      registro1.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-27 12:00:00"));
      registro1.registrarIntervaloAlmocoFim(DateTime.parse("2023-04-27 13:00:00"));
      registro1.registrarSaida(DateTime.parse("2023-04-27 18:00:00"));

      RegistroPonto registro2 = RegistroPonto();
      registro2.registrarEntrada(DateTime.parse("2023-04-28 05:30:00"));

      expect(registro1.possuiIntervaloMinimoEntreDias(registro2), false);

      RegistroPonto registro3 = RegistroPonto();
      registro3.registrarEntrada(DateTime.parse("2023-04-28 07:00:00"));

      expect(registro1.possuiIntervaloMinimoEntreDias(registro3), true);
    });

    test('Deve verificar se o funcionário não excedeu o limite de horas extras diárias', () {
      RegistroPonto registro1 = RegistroPonto();
      registro1.registrarEntrada(DateTime.parse("2023-04-28 08:00:00"));
      registro1.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-28 12:00:00"));
      registro1.registrarIntervaloAlmocoFim(DateTime.parse("2023-04-28 13:00:00"));
      registro1.registrarSaida(DateTime.parse("2023-04-28 17:00:00"));

      expect(registro1.horasExtrasDiarias(), Duration(hours: 0));
      expect(registro1.excedeuLimiteHorasExtrasDiarias(), false);
    });

    test('Deve verificar se o funcionário atingiu o limite de horas extras diárias', () {
      RegistroPonto registro2 = RegistroPonto();
      registro2.registrarEntrada(DateTime.parse("2023-04-28 08:00:00"));
      registro2.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-28 12:00:00"));
      registro2.registrarIntervaloAlmocoFim(DateTime.parse("2023-04-28 13:00:00"));
      registro2.registrarSaida(DateTime.parse("2023-04-28 19:00:00"));

      expect(registro2.horasExtrasDiarias(), Duration(hours: 2));
      expect(registro2.excedeuLimiteHorasExtrasDiarias(), false);
    });

    test('Deve verificar se o funcionário excedeu o limite de horas extras diárias', () {
      RegistroPonto registro3 = RegistroPonto();
      registro3.registrarEntrada(DateTime.parse("2023-04-28 08:00:00"));
      registro3.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-28 12:00:00"));
      registro3.registrarIntervaloAlmocoFim(DateTime.parse("2023-04-28 13:00:00"));
      registro3.registrarSaida(DateTime.parse("2023-04-28 21:00:00"));

      expect(registro3.horasExtrasDiarias(), Duration(hours: 4));
      expect(registro3.excedeuLimiteHorasExtrasDiarias(), true);
    });

    test('Deve verificar se um funcionário não possui registros de ponto nos finais de semana', () {
      RegistroPonto registro = RegistroPonto();

      // Tentando registrar entrada no sábado
      expect(() => registro.registrarEntrada(DateTime.parse("2023-04-29 08:00:00")), throwsA(isA<Exception>()));

      // Tentando registrar entrada no domingo
      expect(() => registro.registrarEntrada(DateTime.parse("2023-04-30 08:00:00")), throwsA(isA<Exception>()));

      // Tentando registrar saída no sábado
      expect(() => registro.registrarSaida(DateTime.parse("2023-04-29 18:00:00")), throwsA(isA<Exception>()));

      // Tentando registrar saída no domingo
      expect(() => registro.registrarSaida(DateTime.parse("2023-04-30 18:00:00")), throwsA(isA<Exception>()));

      // Tentando registrar início do intervalo de almoço no sábado
      expect(() => registro.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-29 12:00:00")), throwsA(isA<Exception>()));

      // Tentando registrar início do intervalo de almoço no domingo
      expect(() => registro.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-30 12:00:00")), throwsA(isA<Exception>()));

      // Tentando registrar fim do intervalo de almoço no sábado
      expect(() => registro.registrarIntervaloAlmocoFim(DateTime.parse("2023-04-29 13:00:00")), throwsA(isA<Exception>()));

      // Tentando registrar fim do intervalo de almoço no domingo
      expect(() => registro.registrarIntervaloAlmocoFim(DateTime.parse("2023-04-30 13:00:00")), throwsA(isA<Exception>()));
    });

    test('Somente o gerente deve realizar o reajuste dos pontos', () {
      Funcionario gerente = Funcionario(nome: 'Gerente', cargo: Cargo(descricao: 'Gerente'));
      Funcionario funcionario = Funcionario(nome: 'Funcionario', cargo: Cargo(descricao: 'Funcionario'));
      RegistroPonto registro = RegistroPonto();

      // Registrar entrada e saída
      registro.registrarEntrada(DateTime.parse("2023-04-28 08:00:00"));
      registro.registrarSaida(DateTime.parse("2023-04-28 18:00:00"));

      // Reajuste de ponto pelo gerente
      expect(() => registro.reajustarPonto(gerente, DateTime.parse("2023-04-28 09:00:00"), DateTime.parse("2023-04-28 17:00:00")), returnsNormally);

      // Reajuste de ponto por funcionário não gerente
      expect(() => registro.reajustarPonto(funcionario, DateTime.parse("2023-04-28 09:00:00"), DateTime.parse("2023-04-28 17:00:00")), throwsA(isA<Exception>()));
    });

    test('Funcionário deve ser notificado quando estiver próximo ao limite de horas permitidas', () {
      Funcionario funcionario = Funcionario(nome: 'Funcionario', cargo: Cargo(descricao: 'Funcionario'));
      RegistroPonto registro = RegistroPonto();

      // Registrar entrada e saída
      registro.registrarEntrada(DateTime.parse("2023-04-28 08:00:00"));
      registro.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-28 12:00:00"));
      registro.registrarIntervaloAlmocoFim(DateTime.parse("2023-04-28 13:00:00"));
      registro.registrarSaida(DateTime.parse("2023-04-28 18:00:00"));

      bool notificado = registro.notificarFuncionario(funcionario);

      // Verificar se o funcionário foi notificado
      expect(notificado, true);

      // Registrar entrada e saída com horas dentro do limite
      registro.registrarEntrada(DateTime.parse("2023-04-28 09:00:00"));
      registro.registrarIntervaloAlmocoInicio(DateTime.parse("2023-04-28 12:00:00"));
      registro.registrarIntervaloAlmocoFim(DateTime.parse("2023-04-28 13:00:00"));
      registro.registrarSaida(DateTime.parse("2023-04-28 17:00:00"));

      notificado = registro.notificarFuncionario(funcionario);

      // Verificar se o funcionário não foi notificado
      expect(notificado, false);
    });

  });
}
