class ClienteDTO {
  final String id;
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
}
