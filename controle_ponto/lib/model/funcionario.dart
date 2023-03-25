class Funcionario {
  String nome;
  List<String> registros = [];
  int bancoHoras = 0;

  Funcionario({required this.nome});

  bool trabalhaMinimoHorasDiarias(int horas) {
    return horas >= 8;
  }

  bool podeFazerHoraExtra(int horasTrabalhadas) {
    return horasTrabalhadas < 9;
  }

  bool permiteAdicionarRegistro(List<String> registrosAtuais) {
    return registrosAtuais.length < 4;
  }

  bool permiteRemoverRegistro(List<String> registrosAtuais) {
    return registrosAtuais.length > 2 && registrosAtuais.length <= 4;
  }

  bool podeAbonarHorasFaltantes(String justificativa) {
    return justificativa.isNotEmpty;
  }

  void calcularBancoHoras() {
    int horasTrabalhadas = 0;
    int horasExtras = 0;

    for (var i = 0; i < registros.length; i++) {
      if (i % 2 == 0) {
        // entrada
        var entrada = DateTime.parse(registros[i]);
        var saida = DateTime.parse(registros[i + 1]);
        var horas = saida.difference(entrada).inHours;

        horasTrabalhadas += horas;

        if (horas > 8) {
          horasExtras += horas - 8;
        }
      }
    }

    bancoHoras = horasExtras;
  }
}
