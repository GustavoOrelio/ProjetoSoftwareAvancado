import 'package:beauty_time/domain/core-private/agendamento.dart';
import 'package:test/test.dart';

void main() {
  group('Agendamento', () {
    test('Deve lançar uma exceção se a data e hora do agendamento forem no passado', () {
      expect(() {
        Agendamento(
          id: '1',
          clienteId: '1',
          funcionarioId: '1',
          servicoId: '1',
          dataHora: DateTime.now().subtract(Duration(days: 1)),
        );
      }, throwsA(isA<Exception>()));
    });

    test('Deve lançar uma exceção se o ID do cliente, funcionário ou serviço for vazio', () {
      expect(() {
        Agendamento(
          id: '1',
          clienteId: '',
          funcionarioId: '1',
          servicoId: '1',
          dataHora: DateTime.now().add(Duration(days: 1)),
        );
      }, throwsA(isA<Exception>()));

      expect(() {
        Agendamento(
          id: '1',
          clienteId: '1',
          funcionarioId: '',
          servicoId: '1',
          dataHora: DateTime.now().add(Duration(days: 1)),
        );
      }, throwsA(isA<Exception>()));

      expect(() {
        Agendamento(
          id: '1',
          clienteId: '1',
          funcionarioId: '1',
          servicoId: '',
          dataHora: DateTime.now().add(Duration(days: 1)),
        );
      }, throwsA(isA<Exception>()));
    });

    test('Deve lançar uma exceção se a data do agendamento for um feriado', () {
      expect(() {
        Agendamento(
          id: '1',
          clienteId: '1',
          funcionarioId: '1',
          servicoId: '1',
          dataHora: DateTime(DateTime.now().year, 12, 25, 10, 0), // Natal
        );
      }, throwsA(isA<Exception>()));
    });

    test('Deve lançar uma exceção se a data do agendamento não for durante o horário de funcionamento do salão', () {
      expect(() {
        Agendamento(
          id: '1',
          clienteId: '1',
          funcionarioId: '1',
          servicoId: '1',
          dataHora: DateTime.now().add(Duration(days: 5, hours: 16)), // 18h
        );
      }, throwsA(isA<Exception>()));
    });
  });
}