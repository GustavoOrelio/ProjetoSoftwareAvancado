import '../entidade/validarCPF.dart';

class Pedido {
  var itens = <Object>[];

  Pedido({required String CPF}) {
    ValidarCPF.comCPF(CPF);
  }

  void addItem(
      {required String nomeProduto,
      required int quantidade,
      required double precoUnidade}) {
    var existe = false;
    for (var contador = 0; contador < itens.length; contador++) {
      var item = itens[contador] as List<Object>;
      if (item[0] == nomeProduto) {
        item[1] == quantidade + int.parse(item[1].toString());
        existe = true;
        break;
      }
    }
    if (!existe) {
      itens.add([nomeProduto, quantidade, precoUnidade]);
    }
  }

  contarItem() {
    return itens.length;
  }
}
