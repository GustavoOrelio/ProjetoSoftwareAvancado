bool ValidarCPF(String cpf) {
  // Remover caracteres não numéricos
  cpf = cpf.replaceAll(RegExp(r'[^\d]'), '');

  // Verificar se o CPF tem 11 dígitos
  if (cpf.length != 11) {
    return false;
  }

  // Verificar se todos os dígitos são iguais
  if (RegExp(r'^(\d)\1{10}$').hasMatch(cpf)) {
    return false;
  }

  // Calcular o primeiro dígito verificador
  var soma = 0;
  for (var i = 0; i < 9; i++) {
    soma += int.parse(cpf[i]) * (10 - i);
  }
  var digito1 = 11 - (soma % 11);
  if (digito1 > 9) {
    digito1 = 0;
  }

  // Calcular o segundo dígito verificador
  soma = 0;
  for (var i = 0; i < 10; i++) {
    soma += int.parse(cpf[i]) * (11 - i);
  }
  var digito2 = 11 - (soma % 11);
  if (digito2 > 9) {
    digito2 = 0;
  }

  // Verificar se os dígitos calculados são iguais aos dígitos informados
  return cpf.endsWith('$digito1$digito2');
}