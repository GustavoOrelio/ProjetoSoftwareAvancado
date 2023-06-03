class ClienteDTO {
  final int id;
  final String nome;
  final String telefone;

  ClienteDTO({required this.id, required this.nome, required this.telefone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
    };
  }

  factory ClienteDTO.fromMap(Map<String, dynamic> map) {
    return ClienteDTO(
      id: map['id'],
      nome: map['nome'],
      telefone: map['telefone'],
    );
  }
}
