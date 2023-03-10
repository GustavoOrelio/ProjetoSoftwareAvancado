import 'package:aula_16_02/entidade/validarCPF.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //CPF não pode ser vazio
  test('CPF vazio deve gerar excessão', () {
    String cpf = '';
    var validarCPF = ValidarCPF();
    expect(() => validarCPF.ehVazio(cpf), throwsException);
  });

  //CPF deve possuir 14 caracteres
  test('CPF deve possuir 14 caracteres', () {
    String cpf = '111.111.111-11';
    var validarCPF = ValidarCPF();
    expect(validarCPF.ehTamanhoCorreto(cpf), true);
    cpf = '1111';
    expect(() => validarCPF.ehTamanhoCorreto(cpf), throwsException);
  });

  //CPF deve possuir o formato correto
  test('CPF deve possuir o formato correto', () {
    String cpf = '111.111.111-11';
    var validarCPF = ValidarCPF();
    expect(validarCPF.ehFormatoCorreto(cpf), true);
    cpf = '1111';
    expect(() => validarCPF.ehFormatoCorreto(cpf), throwsException);
  });

  //CPF sem máscara e sem dígito deve possuir 9 caracteres
  test('CPF deve possuir o formato correto', () {
    String cpf = '111.111.111-11';
    var validarCPF = ValidarCPF();
    List<int> listaNumerosCPF = validarCPF.gerarListaNumeros(cpf);
    expect(listaNumerosCPF.length, 9);
    cpf = '1111';
  });

  test('Deve retornar o primeiro dígito verificador do CPF', () {
    String cpf = '23831045402';
    var validarCPF = ValidarCPF();
    expect(validarCPF.calcularPrimeiroDigitoCpf(cpf), equals(0));
  });

  test('Deve retornar o segundo dígito verificador do CPF', () {
    var validarCPF = ValidarCPF();
    expect(validarCPF.calcularSegundoDigitoCpf('23831045402'), equals(2));
  });

  test('Deve retornar verdadeiro para o CPF', () {
    var validarCPF = ValidarCPF();
    expect(validarCPF.validarCpf('23831045402'), true);
  });

  test('Teste de validação de CPF inválido', () {
    var validarCPF = ValidarCPF();
    expect(validarCPF.validarCpf('12345678910'), false);
    expect(validarCPF.validarCpf(''), false);
  });

}


//Refatorações frequentes, Codigos legiveis, Testes automatizados, Funçoes pequenas.
