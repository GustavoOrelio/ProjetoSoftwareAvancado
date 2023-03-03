import 'package:flutter/material.dart';

import '../components/cliente.dart';
import '../components/produto.dart';
import '../components/venda.dart';

class TelaVenda extends StatefulWidget {
  @override
  _TelaVendaState createState() => _TelaVendaState();
}

class _TelaVendaState extends State<TelaVenda> {
  Cliente _cliente = Cliente('João', 'Rua A, 123');
  Venda _venda = Venda(cliente: Cliente('João', 'Rua A, 123'));
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerPreco = TextEditingController();
  TextEditingController _controllerDesconto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha loja'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cliente: ${_cliente.nome}'),
                  Text('Endereço: ${_cliente.endereco}'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _controllerNome,
                    decoration: InputDecoration(
                      labelText: 'Nome do produto',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _controllerPreco,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Preço do produto',
                      prefixText: 'R\$ ',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      String nome = _controllerNome.text;
                      double preco =
                          double.tryParse(_controllerPreco.text) ?? 0.0;
                      int quantidade = 0;
                      Produto produto = Produto(nome, preco, quantidade);
                      _venda.adicionarProduto(produto);
                      _controllerNome.clear();
                      _controllerPreco.clear();
                      setState(() {});
                    },
                    child: Text('Adicionar produto'),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _venda.produtos.length,
              itemBuilder: (context, index) {
                Produto produto = _venda.produtos[index];
                return ListTile(
                  title: Text(produto.nome),
                  trailing: Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
                  onTap: () {
                    _venda.removerProdutoDoCarrinho(produto);
                    setState(() {});
                  },
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Valor total: R\$ ${_venda.valorTotal.toStringAsFixed(2)}'),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _controllerDesconto,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Desconto (%)',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      double desconto =
                          double.tryParse(_controllerDesconto.text) ?? 0.0;
                      _venda.aplicarDesconto(desconto);
                      _controllerDesconto.clear();
                      setState(() {});
                    },
                    child: Text('Aplicar desconto'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
