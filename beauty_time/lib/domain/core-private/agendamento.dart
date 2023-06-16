class Agendamento {
  final int id;
  final String nomeCliente;
  final String nomeFuncionario;
  final DateTime dataHora;

  Agendamento({
    required this.id,
    required this.nomeCliente,
    required this.nomeFuncionario,
    required this.dataHora,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeCliente': nomeCliente,
      'nomeFuncionario': nomeFuncionario,
      'dataHora': dataHora.toIso8601String(),
    };
  }

  //
}