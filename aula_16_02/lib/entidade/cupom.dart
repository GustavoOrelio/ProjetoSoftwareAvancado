class Cupom {
  String codigo;
  double porcentagem;

  Cupom(this.codigo, this.porcentagem);

  double calcularDesconto(double valor) {
    final desconto = valor * porcentagem / 100.0;
    return valor - desconto;
  }

  double calcularDescontoComCupom(String codigoCupom, double valor) {
    if (codigoCupom != codigo) {
      return valor;
    }
    final desconto = valor * porcentagem / 100.0;
    return valor - desconto;
  }
}
