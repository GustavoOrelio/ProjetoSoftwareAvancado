import 'package:controle_estoque/model/estoque.dart';
import 'package:controle_estoque/model/produto.dart';

class Gerente {
  Estoque _estoque;

  Gerente(this._estoque);

  bool notificarNivelMinimo(Produto produto) {
    return produto.quantidadeEstoque <= produto.nivelMinimoEstoque;
  }

  void atualizarNivelMinimo(Produto produto, int novoNivelMinimo) {
    produto.nivelMinimoEstoque = novoNivelMinimo;
  }

  bool notificarNivelMaximo(Produto produto) {
    return produto.quantidadeEstoque >= produto.nivelMaximoEstoque - 2;
  }

  void atualizarNivelMaximo(Produto produto, int novoNivelMaximo) {
    produto.nivelMaximoEstoque = novoNivelMaximo;
  }

  void adicionarProduto(Produto produto) {
    _estoque.adicionarProduto(produto);
  }

  void removerProduto(Produto produto) {
    _estoque.removerProduto(produto);
  }

  void atualizarPrecoProduto(Produto produto, double novoPreco) {
    produto.preco = novoPreco;
  }
}
