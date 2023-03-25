import 'package:controle_estoque/model/estoque.dart';
import 'package:controle_estoque/model/gerente.dart';
import 'package:controle_estoque/model/produto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Não deve ser possível vender um produto que não está em estoque', () {
    final estoque = Estoque();
    final produto = Produto('Produto 1', 10.0, 0, 1, 10);

    expect(() => estoque.venderProduto(produto), throwsA(isA<Exception>()));
  });

  test('Deve notificar o gerente quando o estoque de um produto atingir o nível mínimo', () {
    final estoque = Estoque();
    final gerente = Gerente(estoque);
    final produto = Produto('Produto 1', 10.0, 1, 1, 10);

    estoque.adicionarProduto(produto);
    estoque.atualizarQuantidadeEstoque(produto, 1);

    expect(gerente.notificarNivelMinimo(produto), isTrue);
  });
}