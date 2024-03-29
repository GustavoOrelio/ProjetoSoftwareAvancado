class FuncionarioDTO {
  final String id;
  final String nome;
  final String cargo;

  FuncionarioDTO({required this.id, required this.nome, required this.cargo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cargo': cargo,
    };
  }

  static FuncionarioDTO fromMap(Map<String, dynamic> map) {
    return FuncionarioDTO(
      id: map['id'],
      nome: map['nome'],
      cargo: map['cargo'],
    );
  }
}
