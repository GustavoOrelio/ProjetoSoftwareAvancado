import 'package:controle_ponto/model/funcionario.dart';
import 'package:controle_ponto/model/gestor.dart';
import 'package:controle_ponto/model/solicitacao.dart';
import 'package:controle_ponto/model/tipo_gestor.dart';
import 'package:controle_ponto/model/tipo_solicitacao.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('O funcionário deve trabalhar no mínimo 8 horas por dia.', () {
    var funcionario = Funcionario(nome: 'João');
    expect(funcionario.trabalhaMinimoHorasDiarias(8), isTrue);
    expect(funcionario.trabalhaMinimoHorasDiarias(7), isFalse);
  });

  test('O funcionário pode fazer no máximo 1 hora extra por dia.', () {
    var funcionario = Funcionario(nome: 'João');
    expect(funcionario.podeFazerHoraExtra(8), isTrue);
    expect(funcionario.podeFazerHoraExtra(9), isFalse);
  });

  test('Pode adicionar registro', () {
    var funcionario = Funcionario(nome: 'João');
    expect(funcionario.permiteAdicionarRegistro([]), isTrue);
    expect(
        funcionario
            .permiteAdicionarRegistro(['08:00', '12:00', '13:00', '17:00']),
        isFalse);
  });

  test('Pode remover registro', () {
    var funcionario = Funcionario(nome: 'João');
    expect(funcionario.permiteRemoverRegistro([]), isFalse);
    expect(funcionario.permiteRemoverRegistro(['08:00', '12:00']), isFalse);
    expect(
        funcionario
            .permiteRemoverRegistro(['08:00', '12:00', '13:00', '17:00']),
        isTrue);
    expect(
        funcionario.permiteRemoverRegistro(
            ['08:00', '12:00', '13:00', '17:00', '18:00']),
        isFalse);
  });

  test('Horas faltantes podem ser abonadas com um motivo.', () {
    var funcionario = Funcionario(nome: 'João');
    expect(funcionario.podeAbonarHorasFaltantes('Motivo'), isTrue);
    expect(funcionario.podeAbonarHorasFaltantes(''), isFalse);
  });

  test(
      'Os abonos de horas faltantes só serão aceitos com devida justificativa com anexo.',
      () {
    var funcionario = Funcionario(nome: 'João');
    var solicitacao = Solicitacao(
        funcionario: funcionario,
        tipo: TipoSolicitacao.HORAS_EXTRAS,
        justificativa: 'Ficou até mais tarde',
        anexo: '');
    expect(solicitacao.aprovada, isFalse);
  });

  test(
      'Para ajustar algum horário já cadastrado deverá ser feita a solicitação ao gestor.',
      () {
    var gestor = Gestor(nome: 'Gestor', tipo: TipoGestor.NORMAL);
    expect(gestor.podeAprovarSolicitacao(TipoSolicitacao.HORAS_EXTRAS), isTrue);
    expect(
        gestor.podeAprovarSolicitacao(TipoSolicitacao.AJUSTE_HORARIO), isTrue);
    expect(gestor.podeAprovarSolicitacao(TipoSolicitacao.ABONO_HORAS_FALTANTES),
        isFalse);
  });

  test('Os abonos de horas faltantes devem ser aprovadas pelo administrador.',
      () {
    var gestor = Gestor(nome: 'Gestor', tipo: TipoGestor.ADMINISTRADOR);
    expect(gestor.podeAprovarSolicitacao(TipoSolicitacao.HORAS_EXTRAS), isTrue);
    expect(
        gestor.podeAprovarSolicitacao(TipoSolicitacao.AJUSTE_HORARIO), isTrue);
    expect(gestor.podeAprovarSolicitacao(TipoSolicitacao.ABONO_HORAS_FALTANTES),
        isTrue);
  });

  test(
      'Empresa que paga horas extras não deve permitir descontar do banco de horas',
      () {
    var funcionario = Funcionario(nome: 'João');

    funcionario.registros.addAll(['08:00', '12:00', '13:00', '19:00']);

    expect(funcionario.bancoHoras, equals(0));
  });

  test('Deve permitir entrada de 4 registros por dia', () {
    var funcionario = Funcionario(nome: 'Maria');

    funcionario.registros.addAll([
      '2023-03-24 08:00:00', // entrada
      '2023-03-24 12:00:00', // saída
      '2023-03-24 13:00:00', // entrada
      '2023-03-24 18:00:00', // saída
      '2023-03-24 19:00:00', // entrada extra
      '2023-03-24 20:00:00', // saída extra
    ]);

    expect(funcionario.permiteAdicionarRegistro(funcionario.registros),
        equals(isFalse));
  });
}
