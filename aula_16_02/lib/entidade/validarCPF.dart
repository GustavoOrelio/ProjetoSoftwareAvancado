class ValidarCPF {
  ValidarCPF(String cpf);

  ValidarCPF.comCPF(String CPF) {
    ehVazio(CPF);
    ehTamanhoCorreto(CPF);
    ehFormatoCorreto(CPF);
  }

  bool ehVazio(String cpf) {
    if (cpf.isEmpty) throw Exception('CPF não pode ser vazio');
    return true;
  }

  bool ehTamanhoCorreto(String cpf) {
    if (cpf.length != 14) throw Exception('CPF deve conter 14 caracteres');
    return true;
  }

  bool ehFormatoCorreto(String cpf) {
    var regExp = RegExp(r'\d{3}\.\d{3}\.\d{3}\-\d{2}');
    if (!regExp.hasMatch(cpf))
      throw Exception('CPF deve possuir o formato ###.###.###-##');
    return true;
  }

  List<int> gerarListaNumeros(String cpfCompleto) {
    ehVazio(cpfCompleto);
    var cpfSemMascara = cpfCompleto.replaceAll('.', '').replaceAll('-', '');
    var cpfSemDigito = cpfSemMascara.substring(0, 9);
    List<String> listaCaracteres = cpfSemDigito.split('');
    List<int> listaNumeros =
        listaCaracteres.map<int>((elemento) => int.parse(elemento)).toList();
    return listaNumeros;
  }

  int calcularPrimeiroDigitoCpf(String cpf) {
    List<int> digitos = cpf.split('').map(int.parse).toList();
    int soma = 0;
    int multiplicador = 10;

    for (int i = 0; i < 9; i++) {
      soma += digitos[i] * multiplicador;
      multiplicador--;
    }

    int resto = soma % 11;
    return resto < 2 ? 0 : 11 - resto;
  }

  int calcularSegundoDigitoCpf(String cpf) {
    List<int> digitos = cpf.split('').map(int.parse).toList();
    int soma = 0;
    int multiplicador = 11;

    for (int i = 0; i < 9; i++) {
      soma += digitos[i] * multiplicador;
      multiplicador--;
    }

    int resto = soma % 11;
    return resto < 2 ? 0 : 11 - resto;
  }

  bool validarCpf(String cpf) {
    List<int> digitos = cpf.split('').map(int.parse).toList();

    if (digitos.length != 11) {
      return false;
    }

    List<int> digitosVerificadores = digitos.sublist(9);

    int primeiroDigito = calcularDigitoVerificador(digitos.sublist(0, 9),
        multiplicadorInicial: 10);

    int segundoDigito = calcularDigitoVerificador(
        digitos.sublist(0, 9) + [primeiroDigito],
        multiplicadorInicial: 11);

    return digitosVerificadores[0] == primeiroDigito &&
        digitosVerificadores[1] == segundoDigito;
  }

  int calcularDigitoVerificador(List<int> digitos,
      {int multiplicadorInicial = 11}) {
    int soma = 0;
    int multiplicador = multiplicadorInicial;

    for (int i = 0; i < digitos.length; i++) {
      soma += digitos[i] * multiplicador;
      multiplicador--;
    }

    int resto = soma % 11;

    if (resto < 2) {
      return 0;
    } else {
      return 11 - resto;
    }
  }
}
