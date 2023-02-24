bool ValidarCPF(String cpf) {
  cpf = cpf.replaceAll(RegExp(r'[^\d]'), '');

  if (cpf.length != 11) {
    return false;
  }

  if (RegExp(r'^(\d)\1{10}$').hasMatch(cpf)) {
    return false;
  }

  var soma = 0;
  for (var i = 0; i < 9; i++) {
    soma += int.parse(cpf[i]) * (10 - i);
  }
  var digito1 = 11 - (soma % 11);
  if (digito1 > 9) {
    digito1 = 0;
  }

  soma = 0;
  for (var i = 0; i < 10; i++) {
    soma += int.parse(cpf[i]) * (11 - i);
  }
  var digito2 = 11 - (soma % 11);
  if (digito2 > 9) {
    digito2 = 0;
  }

  return cpf.endsWith('$digito1$digito2');
}
