class ServicoDTO {
  final int id;
  final String nome;
  final String valor;

  ServicoDTO({required this.id, required this.nome, required this.valor});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'valor': valor,
    };
  }

  factory ServicoDTO.fromMap(Map<String, dynamic> map) {
    return ServicoDTO(
      id: map['id'],
      nome: map['nome'],
      valor: map['valor'],
    );
  }
}
