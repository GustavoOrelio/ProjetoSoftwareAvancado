import 'package:aula_16_02/entidade/itemPedido.dart';
import 'package:aula_16_02/entidade/validarCPF.dart';

class Pedido {
  final List<ItemPedido> itens;
  double total = 0;

  Pedido({required String cpf}) : itens = <ItemPedido>[] {
    validarCPF(cpf);
  }

  double addItem({
    required String nomeProduto,
    required int quantidade,
    required double precoUnidade,
    double descontoEmReais = 0,
  }) {
    final existe = itens.any((item) => item.nomeProduto == nomeProduto);

    final totalItem = ItemPedido.calcularTotalItem(
      quantidade: quantidade,
      precoUnidade: precoUnidade,
      descontoEmReais: descontoEmReais,
    );

    if (existe) {
      final itemExistente =
          itens.firstWhere((item) => item.nomeProduto == nomeProduto);
      itemExistente.quantidade += quantidade;
      itemExistente.totalItem += totalItem;
    } else {
      itens.add(
        ItemPedido(
          nomeProduto: nomeProduto,
          quantidade: quantidade,
          precoUnidade: precoUnidade,
          descontoEmReais: descontoEmReais,
        ),
      );
    }

    total += totalItem;
    return totalItem;
  }

  int contarItens() => itens.length;

  double getTotal() => total;

  void validarCPF(String cpf) {
    ValidarCPF.comCPF(cpf);
  }
}
