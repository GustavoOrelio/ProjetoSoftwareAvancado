// deve validar e calcular o desconto de um cupom de desconto
// deve adicionar um cupom de desconto

import 'package:aula_16_02/entidade/cupom.dart';
import 'package:aula_16_02/entidade/pedido.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Não deve criar pedido com CPF inválido', () {
    expect(() => Pedido(cpf: '111'), throwsException);
  });

  test('Deve criar um pedido com 3 itens', () {
    var pedido = Pedido(cpf: '264.310.820-52');
    pedido.addItem(nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.5);
    pedido.addItem(nomeProduto: 'fanta', quantidade: 1, precoUnidade: 6);
    pedido.addItem(nomeProduto: 'chokito', quantidade: 3, precoUnidade: 3.5);
    expect(pedido.contarItens(), 3);
  });

  test(
      'Ao adicionar um produto existente no pedido, deve alterar a quantidade sem criar um novo item',
      () {
    var pedido = Pedido(cpf: '264.310.820-52');
    pedido.addItem(nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.5);
    pedido.addItem(nomeProduto: 'coca-cola', quantidade: 1, precoUnidade: 6.5);
    pedido.addItem(nomeProduto: 'chokito', quantidade: 3, precoUnidade: 3.5);
    expect(pedido.contarItens(), 2);
  });

  test('Deve apresentar a soma de um item corretamente', () {
    var pedido = Pedido(cpf: '264.310.820-52');
    var totalItem = pedido.addItem(
        nomeProduto: 'coca-cola', quantidade: 2, precoUnidade: 6.5);
    expect(totalItem, 13.0);
  });

  test('Deve permitir desconto do item de no máximo 15%', () {
    var pedido = Pedido(cpf: '264.310.820-52');
    expect(
        () => pedido.addItem(
            nomeProduto: 'coca-cola',
            quantidade: 2,
            precoUnidade: 6.5,
            descontoEmReais: 3),
        throwsException);
    expect(
        pedido.addItem(
            nomeProduto: 'fanta',
            quantidade: 2,
            precoUnidade: 5,
            descontoEmReais: 1.5),
        8.5);
  });

  test('Deve apresentar o total do pedido corretamente', () {
    var pedido = Pedido(cpf: '264.310.820-52');
    pedido.addItem(
      nomeProduto: 'coca-cola',
      quantidade: 2,
      precoUnidade: 6.5,
    );
    pedido.addItem(
      nomeProduto: 'fanta',
      quantidade: 5,
      precoUnidade: 1.5,
    );
    expect(pedido.getTotal(), 20.5);
  });

  test('Deve adicionar um cupom de desconto', () {
    var cupom = Cupom('ABC123', 10.0);
    var valor = 100.0;
    expect(cupom.calcularDesconto(valor), 90.0);
  });

  test('Deve validar e calcular o desconto de um cupom de desconto', () {
    var cupom = Cupom('ABC123', 10.0);
    var valor = 100.0;
    var expectedValue = valor;

    expect(
        cupom.calcularDescontoComCupom('XYZ456', valor), equals(expectedValue));
  });
}
