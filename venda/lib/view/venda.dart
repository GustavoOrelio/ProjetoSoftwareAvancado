import 'package:flutter/material.dart';

import '../components/cliente.dart';
import '../components/produto.dart';
import '../components/venda.dart';

class TelaVenda extends StatefulWidget {
  const TelaVenda({Key? key}) : super(key: key);

  @override
  _TelaVendaState createState() => _TelaVendaState();
}

class _TelaVendaState extends State<TelaVenda> {
  final Cliente _cliente = Cliente('João', 'Rua A, 123');
  final Venda _venda = Venda(cliente: Cliente('João', 'Rua A, 123'));
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerPreco = TextEditingController();
  final TextEditingController _controllerDesconto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cliente: ${_cliente.nome}'),
                  Text('Endereço: ${_cliente.endereco}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _controllerNome,
                    decoration: const InputDecoration(
                      labelText: 'Nome do produto',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _controllerPreco,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Preço do produto',
                      prefixText: 'R\$ ',
                    ),
                  ),
                  const SizedBox(height: 16.0),
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
                    child: const Text('Adicionar produto'),
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Valor total: R\$ ${_venda.valorTotal.toStringAsFixed(2)}'),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _controllerDesconto,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Desconto (%)',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      double desconto =
                          double.tryParse(_controllerDesconto.text) ?? 0.0;
                      _venda.aplicarDesconto(desconto);
                      _controllerDesconto.clear();
                      setState(() {});
                    },
                    child: const Text('Aplicar desconto'),
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
