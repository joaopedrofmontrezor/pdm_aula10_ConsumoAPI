import 'package:flutter/material.dart';
import '../models/produto.dart';

class ProdutoCard extends StatelessWidget {
  final Produto produto;

  const ProdutoCard({
    super.key,
    required this.produto,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: produto.temEstoqueCritico
              ? Colors.red.shade100
              : Colors.blue.shade100,
          child: Icon(
            produto.temEstoqueCritico
                ? Icons.warning_amber_rounded
                : Icons.inventory_2_outlined,
            color: produto.temEstoqueCritico ? Colors.red : Colors.blue,
          ),
        ),
        title: Text(
          produto.nomeProduto,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Estoque: ${produto.quantidadeEstoque} unidades'),
        trailing: Text(
          'R\$ ${produto.preco.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}