class FuncionarioDTO {
  final int id;
  final String nome;
  final String telefone;

  FuncionarioDTO({required this.id, required this.nome, required this.telefone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
    };
  }

  factory FuncionarioDTO.fromMap(Map<String, dynamic> map) {
    return FuncionarioDTO(
      id: map['id'],
      nome: map['nome'],
      telefone: map['telefone'],
    );
  }
}
