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
  test('Cria registros de ponto corretamente', () {
    final entrada = RegistroPonto.criar(TipoRegistroPonto.ENTRADA, DateTime.now());
    final saida = RegistroPonto.criar(TipoRegistroPonto.SAIDA, DateTime.now());
    final almocoInicio = RegistroPonto.criar(TipoRegistroPonto.ALMOCO_INICIO, DateTime.now());
    final almocoFim = RegistroPonto.criar(TipoRegistroPonto.ALMOCO_FIM, DateTime.now());

    expect(entrada.runtimeType, Entrada);
    expect(saida.runtimeType, Saida);
    expect(almocoInicio.runtimeType, AlmocoInicio);
    expect(almocoFim.runtimeType, AlmocoFim);
  });

  test('Registra ponto corretamente', () {
    final funcionario = Funcionario(nome: 'João');
    funcionario.registrarPonto(TipoRegistroPonto.ENTRADA);
    funcionario.registrarPonto(TipoRegistroPonto.ALMOCO_INICIO);
    funcionario.registrarPonto(TipoRegistroPonto.ALMOCO_FIM);
    funcionario.registrarPonto(TipoRegistroPonto.SAIDA);

    expect(funcionario.registros.length, 4);
    expect(funcionario.registros[0].runtimeType, Entrada);
    expect(funcionario.registros[1].runtimeType, AlmocoInicio);
    expect(funcionario.registros[2].runtimeType, AlmocoFim);
    expect(funcionario.registros[3].runtimeType, Saida);
  });

  test('Verifica proximidade do limite de horas', () {
    final funcionario = Funcionario(nome: 'João');

    // Adicionando registros de ponto
    final hoje = DateTime.now();
    final ontem = DateTime.now().subtract(Duration(days: 1));

    // Registros de ontem
    funcionario.registros.add(Entrada(horario: ontem.add(Duration(hours: 8))));
    funcionario.registros.add(AlmocoInicio(horario: ontem.add(Duration(hours: 12))));
    funcionario.registros.add(AlmocoFim(horario: ontem.add(Duration(hours: 13))));
    funcionario.registros.add(Saida(horario: ontem.add(Duration(hours: 18))));

    // Registros de hoje
    funcionario.registros.add(Entrada(horario: hoje.add(Duration(hours: 8))));
    funcionario.registros.add(AlmocoInicio(horario: hoje.add(Duration(hours: 12))));
    funcionario.registros.add(AlmocoFim(horario: hoje.add(Duration(hours: 13))));
    funcionario.registros.add(Saida(horario: hoje.add(Duration(hours: 19, minutes: 30)))); // 9,5 horas de trabalho hoje

    // Verifica se o funcionário está próximo do limite de horas extras diárias (2 horas)
    expect(funcionario.isProximoLimiteHoras(2), true);
  });

  test('Valida registros corretamente', () {
    final validacao = ValidacaoRegistroFuncionario();
    final registros = <RegistroPonto>[];

    // Adicionando registros de ponto
    final hoje = DateTime.now();
    final ontem = DateTime.now().subtract(Duration(days: 1));

    // Registros de ontem
    registros.add(Entrada(horario: ontem.add(Duration(hours: 8))));
    registros.add(AlmocoInicio(horario: ontem.add(Duration(hours: 12))));
    registros.add(AlmocoFim(horario: ontem.add(Duration(hours: 13))));
    registros.add(Saida(horario: ontem.add(Duration(hours: 18))));

    // Registros de hoje
    registros.add(Entrada(horario: hoje.add(Duration(hours: 8))));
    registros.add(AlmocoInicio(horario: hoje.add(Duration(hours: 12))));
    registros.add(AlmocoFim(horario: hoje.add(Duration(hours: 13))));
    registros.add(Saida(horario: hoje.add(Duration(hours: 19, minutes: 30)))); // 9,5 horas de trabalho hoje

    // Testa a validação de um novo registro de entrada
    expect(
            () => validacao.validarRegistro(
            TipoRegistroPonto.ENTRADA, DateTime.now(), registros),
        returnsNormally); // Ou use expect para verificar se a validação lança uma exceção, caso necessário
  });

  test('Valida diferentes cenários de registros de ponto', () {
    final validacao = MockValidacaoRegistro();
    final registros = <RegistroPonto>[];

    // Adicionando registros de ponto
    final hoje = DateTime.now();
    final ontem = DateTime.now().subtract(Duration(days: 1));

    // Registros de ontem
    registros.add(Entrada(horario: ontem.add(Duration(hours: 8))));
    registros.add(AlmocoInicio(horario: ontem.add(Duration(hours: 12))));
    registros.add(AlmocoFim(horario: ontem.add(Duration(hours: 13))));
    registros.add(Saida(horario: ontem.add(Duration(hours: 18))));

    // Registros de hoje
    registros.add(Entrada(horario: hoje.add(Duration(hours: 8))));
    registros.add(AlmocoInicio(horario: hoje.add(Duration(hours: 12))));
    registros.add(AlmocoFim(horario: hoje.add(Duration(hours: 13))));
    registros.add(Saida(horario: hoje.add(Duration(hours: 19, minutes: 30)))); // 9,5 horas de trabalho hoje

    // Testa a validação de um novo registro de início de almoço após um registro de saída
    expect(validacao.validarRegistro(
        TipoRegistroPonto.ALMOCO_INICIO, DateTime.now(), registros),
        true);

    // Adiciona um registro de entrada
    registros.add(Entrada(horario: hoje.add(Duration(hours: 20))));

    // Testa a validação de um novo registro de saída sem um registro de início de almoço
    expect(validacao.validarRegistro(
        TipoRegistroPonto.SAIDA, DateTime.now(), registros),
        true);

    // Adiciona um registro de início de almoço
    registros.add(AlmocoInicio(horario: hoje.add(Duration(hours: 22))));

    // Testa a validação de um novo registro de saída após um registro de início de almoço
    expect(validacao.validarRegistro(
        TipoRegistroPonto.SAIDA, DateTime.now(), registros),
        true);
  });
}


