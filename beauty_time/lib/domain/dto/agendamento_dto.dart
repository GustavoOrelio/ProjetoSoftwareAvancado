class AgendamentoDTO {
  final String id;
  final String clienteId;
  final String funcionarioId;
  final String servicoId;
  final DateTime dataHora;

  AgendamentoDTO({
    required this.id,
    required this.clienteId,
    required this.funcionarioId,
    required this.servicoId,
    required this.dataHora,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clienteId': clienteId,
      'funcionarioId': funcionarioId,
      'servicoId': servicoId,
      'dataHora': dataHora.toIso8601String(),
    };
  }

  static AgendamentoDTO fromMap(Map<String, dynamic> map) {
    return AgendamentoDTO(
      id: map['id'],
      clienteId: map['clienteId'],
      funcionarioId: map['funcionarioId'],
      servicoId: map['servicoId'],
      dataHora: DateTime.parse(map['dataHora']),
    );
  }
}
