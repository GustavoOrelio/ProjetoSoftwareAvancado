import 'package:controle_ponto/model/Classe.dart';
import 'package:flutter_test/flutter_test.dart';

/*
1 - O registro de ponto deve consistir em entrada e saída com o devido horário (entrada e saída) de almoco de 1h.
2 - Todo funcionario deve possuir o horário de trabalho mínimo de 8 horas com o interstício de almoco de 1h. Os horário são flexível.
3 - Cada turno deve possuir na máximo 5 horas de trabalho e no mínimo 3 horas.
4 - O interstício de trabalho de um dia para o outro deve ser de no mínimo 12 horas.
5 - A quantidade de horas extras deve se de no máximo 2 horas diárias, 8 semanais e 15 mensais.
6 - Final de semana não deve possuir registros.
7 - Somente o gerente poderá realizar o reajuste.
8 - O funcionário deve ser notificado, quando estiver trabalhando próximo ao limite de horas permitidas.
9 - O funcionário poderá solicitar o abono de horas faltantes mediante justificativas que será analizado pelo gerente.
10 - O funcionario só poderá realizar horas extras mediante autorização do gerente.
*/

void main() {
  group('Funcionario', () {
    test('Deve registrar entrada', () {
      final funcionario = Funcionario(nome: 'João');
      funcionario.registrarPonto(TipoRegistroPonto.ENTRADA);

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.SAIDA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 1);
    });

    test('Deve registrar início do almoço', () {
      final funcionario = Funcionario(nome: 'João');
      funcionario.registrarPonto(TipoRegistroPonto.ENTRADA);

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.SAIDA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 1);

      final horarioEntrada = DateTime.now().subtract(Duration(hours: 5));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ENTRADA, horario: horarioEntrada));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.ALMOCO_INICIO),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 2);
    });

    test('Deve registrar fim do almoço', () {
      final funcionario = Funcionario(nome: 'João');
      funcionario.registrarPonto(TipoRegistroPonto.ENTRADA);

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.SAIDA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 1);

      final horarioEntrada = DateTime.now().subtract(Duration(hours: 5));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ENTRADA, horario: horarioEntrada));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.ALMOCO_INICIO),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 2);

      final horarioAlmocoInicio = horarioEntrada.add(Duration(hours: 3));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ALMOCO_INICIO, horario: horarioAlmocoInicio));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.ALMOCO_FIM),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 3);
    });

    test('Deve registrar saída', () {
      final funcionario = Funcionario(nome: 'João');
      funcionario.registrarPonto(TipoRegistroPonto.ENTRADA);

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.SAIDA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 1);

      final horarioEntrada = DateTime.now().subtract(Duration(hours: 5));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ENTRADA, horario: horarioEntrada));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.ALMOCO_INICIO),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 2);

      final horarioAlmocoInicio = horarioEntrada.add(Duration(hours: 3));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ALMOCO_INICIO, horario: horarioAlmocoInicio));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.ALMOCO_FIM),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 3);

      final horarioAlmocoFim = horarioAlmocoInicio.add(Duration(hours: 2));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ALMOCO_FIM, horario: horarioAlmocoFim));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.SAIDA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 4);
    });

    test('Não deve registrar mais de uma entrada por dia', () {
      final funcionario = Funcionario(nome: 'João');
      funcionario.registrarPonto(TipoRegistroPonto.ENTRADA);

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.ENTRADA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 1);
    });

    test('Não deve registrar mais de uma saída por dia', () {
      final funcionario = Funcionario(nome: 'João');
      funcionario.registrarPonto(TipoRegistroPonto.ENTRADA);

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.SAIDA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 1);

      final horarioEntrada = DateTime.now().subtract(Duration(hours: 5));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ENTRADA, horario: horarioEntrada));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.ALMOCO_INICIO),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 2);

      final horarioAlmocoInicio = horarioEntrada.add(Duration(hours: 3));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ALMOCO_INICIO, horario: horarioAlmocoInicio));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.ALMOCO_FIM),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 3);

      final horarioAlmocoFim = horarioAlmocoInicio.add(Duration(hours: 2));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ALMOCO_FIM, horario: horarioAlmocoFim));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.SAIDA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 4);
    });

    test('Não deve registrar início do almoço sem entrada', () {
      final funcionario = Funcionario(nome: 'João');

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.ALMOCO_INICIO),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 0);
    });

    test('Não deve registrar fim do almoço sem início do almoço', () {
      final funcionario = Funcionario(nome: 'João');
      funcionario.registrarPonto(TipoRegistroPonto.ENTRADA);

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.ALMOCO_FIM),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 1);
    });

    test('Não deve registrar saída sem fim do almoço', () {
      final funcionario = Funcionario(nome: 'João');
      funcionario.registrarPonto(TipoRegistroPonto.ENTRADA);

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.SAIDA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 1);
    });

    test('Deve validar duração do turno', () {
      final funcionario = Funcionario(nome: 'João');
      funcionario.registrarPonto(TipoRegistroPonto.ENTRADA);

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.SAIDA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 1);

      final horarioEntrada = DateTime.now().subtract(Duration(hours: 5));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ENTRADA, horario: horarioEntrada));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.ALMOCO_INICIO),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 2);

      final horarioAlmocoInicio = horarioEntrada.add(Duration(hours: 3));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ALMOCO_INICIO, horario: horarioAlmocoInicio));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.ALMOCO_FIM),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 3);

      final horarioAlmocoFim = horarioAlmocoInicio.add(Duration(hours: 2));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ALMOCO_FIM, horario: horarioAlmocoFim));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.SAIDA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 4);
    });

    test('Deve validar horário mínimo de trabalho', () {
      final funcionario = Funcionario(nome: 'João');
      final horarioEntrada = DateTime.now().subtract(Duration(hours: 7));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ENTRADA, horario: horarioEntrada));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.SAIDA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 1);
    });

    test('Não deve registrar ponto nos finais de semana', () {
      final funcionario = Funcionario(nome: 'João');
      final horarioEntrada = DateTime.now().subtract(Duration(days: 2));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ENTRADA, horario: horarioEntrada));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.SAIDA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 1);
    });

    test('Deve validar interstício de trabalho de um dia para o outro', () {
      final funcionario = Funcionario(nome: 'João');
      final horarioSaidaOntem = DateTime.now().subtract(Duration(hours: 18));
      funcionario.registros.add(RegistroPonto(tipo: TipoRegistroPonto.SAIDA, horario: horarioSaidaOntem));

      expect(() => funcionario.registrarPonto(TipoRegistroPonto.SAIDA),
          throwsA(isA<Exception>()));
      expect(funcionario.registros.length, 1);

      final horarioEntradaHoje = horarioSaidaOntem.add(Duration(hours: 9));
      funcionario.registros.add(RegistroPonto(tipo: TipoRegistroPonto.ENTRADA, horario: horarioEntradaHoje));

      expect(funcionario.registros.length, 2);
    });

    test('Deve verificar se o funcionário está próximo do limite de horas permitidas', () {
      final funcionario = Funcionario(nome: 'João');

      final horarioEntrada = DateTime.now().subtract(Duration(hours: 8));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ENTRADA, horario: horarioEntrada));

      final horarioAlmocoInicio = horarioEntrada.add(Duration(hours: 3));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ALMOCO_INICIO, horario: horarioAlmocoInicio));

      final horarioAlmocoFim = horarioAlmocoInicio.add(Duration(hours: 1));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ALMOCO_FIM, horario: horarioAlmocoFim));

      final horarioSaida = horarioAlmocoFim.add(Duration(hours: 8));
      funcionario.registros.add(
          RegistroPonto(tipo: TipoRegistroPonto.SAIDA, horario: horarioSaida));

      expect(funcionario.isProximoLimiteHoras(12), isFalse);

      final horarioEntradaHoje = horarioSaida.add(Duration(hours: 1));
      funcionario.registros.add(RegistroPonto(
          tipo: TipoRegistroPonto.ENTRADA, horario: horarioEntradaHoje));

      expect(funcionario.isProximoLimiteHoras(10), isFalse);
    });
  });
}
