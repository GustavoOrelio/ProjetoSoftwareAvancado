bool ValidarCNPJ(String cnpj) {
  cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

  if (cnpj.length != 14) return false;

  if (RegExp(r'^(\d)\1*$').hasMatch(cnpj)) return false;
  
  List<int> digitos = cnpj.split('').map((e) => int.parse(e)).toList();
  int soma = 0;
  int peso = 2;
  for (int i = 11; i >= 0; i--) {
    soma += digitos[i] * peso;
    peso = peso == 9 ? 2 : peso + 1;
  }
  int dv1 = (soma % 11) < 2 ? 0 : 11 - (soma % 11);

  soma = 0;
  peso = 2;
  for (int i = 12; i >= 0; i--) {
    soma += digitos[i] * peso;
    peso = peso == 9 ? 2 : peso + 1;
  }
  int dv2 = (soma % 11) < 2 ? 0 : 11 - (soma % 11);

  return dv1 == digitos[12] && dv2 == digitos[13];
}