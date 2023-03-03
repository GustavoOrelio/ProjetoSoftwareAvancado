import 'cliente.dart';
import 'produto.dart';

class Venda {
  Cliente cliente;
  List<Produto> produtos;
  double valorTotal;

  Venda({required this.cliente})
      : produtos = [],
        valorTotal = 0;

  void adicionarProduto(Produto produto) {
    if (produtos.contains(produto)) {
      Produto p = produtos[produtos.indexOf(produto)];
      p.quantidade += produto.quantidade;
      valorTotal += produto.preco * produto.quantidade;
    } else {
      produtos.add(produto);
      valorTotal += produto.preco * produto.quantidade;
    }
  }

  void removerProdutoDoCarrinho(Produto produto) {
    produtos.remove(produto);
    valorTotal -= produto.preco * produto.quantidade;
  }

  void aplicarDesconto(double percentualDesconto) {
    if (percentualDesconto <= 0) return;
    double valorDesconto = valorTotal * percentualDesconto / 100;
    valorTotal -= valorDesconto;
  }
}
