class ServicoDTO {
  final String id;
  final String nome;
  final double preco;

  ServicoDTO({required this.id, required this.nome, required this.preco});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'preco': preco,
    };
  }

  static ServicoDTO fromMap(Map<String, dynamic> map) {
    return ServicoDTO(
      id: map['id'],
      nome: map['nome'],
      preco: map['preco'],
    );
  }
}
