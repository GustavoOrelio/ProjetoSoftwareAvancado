class AgendamentoDTO {
  final int id;
  final String nomeCliente;
  final String nomeFuncionario;
  final String dataHora;

  AgendamentoDTO({
    required this.id,
    required this.nomeCliente,
    required this.nomeFuncionario,
    required this.dataHora,
  });
}