// não deve criar um pedido com CPF inválido
//→ CPF válido 264.310.820-52
// deve criar um pedido com 3 itens
// ao adicionar um produto existente no pedido, deve alterar a quantidade sem criar um novo item
// deve apresentar a soma de um item corretamente
// deve permitir desconto do item de no máximo 15%
// deve apresentar o total do pedido corretamente
// deve validar e calcular o desconto de um cupom de desconto
// deve adicionar um cupom de desconto

import 'package:aula_16_02/entidade/pedido.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Não deve criar pedido com CPF inválido', () {
    expect(() => Pedido(CPF: '111'), throwsException);
  });

  test('Deve criar um pedido com 3 itens', () {
    var pedido = Pedido(CPF: '264.310.820-52');
    pedido.addItem(nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.5);
    pedido.addItem(nomeProduto: 'fanta', quantidade: 1, precoUnidade: 6);
    pedido.addItem(nomeProduto: 'chokito', quantidade: 3, precoUnidade: 3.5);
    expect(pedido.contarItem(), 3);
  });

  test('Ao adicionar um produto existente no pedido, deve alterar a quantidade sem criar um novo item', () {
    var pedido = Pedido(CPF: '264.310.820-52');
    pedido.addItem(nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.5);
    pedido.addItem(nomeProduto: 'coca-cola', quantidade: 1, precoUnidade: 6.5);
    pedido.addItem(nomeProduto: 'chokito', quantidade: 3, precoUnidade: 3.5);
    expect(pedido.contarItem(), 2);
  });
}
