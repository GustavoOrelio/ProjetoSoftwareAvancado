import 'package:controle_estoque/model/produto.dart';

class Estoque {
  List<Produto> _produtos = [];

  void adicionarProduto(Produto produto) {
    _produtos.add(produto);
  }

  void removerProduto(Produto produto) {
    _produtos.remove(produto);
  }

  Produto buscarProduto(String nome) {
    return _produtos.firstWhere((p) => p.nome == nome, orElse: null );
  }

  double calcularValorTotal() {
    return _produtos.fold(
        0, (total, p) => total + p.preco * p.quantidadeEstoque);
  }

  void venderProduto(Produto produto) {
    if (!produtoDisponivel(produto)) {
      throw Exception('Produto não está disponível no estoque');
    }

    // realiza a venda do produto
  }

  bool produtoDisponivel(Produto produto) {
    return _produtos.contains(produto) && produto.quantidadeEstoque > 0;
  }

  void atualizarQuantidadeEstoque(Produto produto, int quantidade) {
    if (!produtoDisponivel(produto)) {
      throw Exception('Produto não está disponível no estoque');
    }

    if (produto.quantidadeEstoque + quantidade > produto.nivelMaximoEstoque) {
      throw Exception('Quantidade excede o nível máximo de estoque');
    }

    produto.quantidadeEstoque += quantidade;
  }
}
