class AgendamentoDTO {
  final int id;
  final DateTime dataHora;
  final String clienteId;
  final String funcionarioId;
  final String servicoId;

  AgendamentoDTO(
      {required this.id,
      required this.dataHora,
      required this.clienteId,
      required this.funcionarioId,
      required this.servicoId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'datahora': dataHora,
      'cliente': clienteId,
      'funcionario': funcionarioId,
      'servico': servicoId,
    };
  }

  factory AgendamentoDTO.fromMap(Map<String, dynamic> map) {
    return AgendamentoDTO(
      id: map['id'],
      dataHora: map['datahora'],
      clienteId: map['cliente'],
      funcionarioId: map['funcionario'],
      servicoId: map['servico'],
    );
  }
}
