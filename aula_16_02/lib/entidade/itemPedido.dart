class ItemPedido {
  final String nomeProduto;
  int quantidade;
  final double precoUnidade;
  double totalItem;

  ItemPedido({
    required this.nomeProduto,
    required this.quantidade,
    required this.precoUnidade,
    required double descontoEmReais,
  }) : totalItem = calcularTotalItem(
          quantidade: quantidade,
          precoUnidade: precoUnidade,
          descontoEmReais: descontoEmReais,
        );

  static double calcularTotalItem({
    required int quantidade,
    required double precoUnidade,
    required double descontoEmReais,
  }) {
    final totalItem = quantidade * precoUnidade;
    final descontoPermitido = totalItem * 0.15;

    if (descontoEmReais > descontoPermitido) {
      throw Exception('Desconto maior do que o permitido');
    }

    return totalItem - descontoEmReais;
  }
}
