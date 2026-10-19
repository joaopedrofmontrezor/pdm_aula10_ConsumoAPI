import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../widgets/produto_card.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  bool _isLoading = false;
  List<Produto> _produtos = [];

  
  final String _jsonRawData = '''
  [
    {
      "id_produto": 12345,
      "nome_produto": "Turbina de Alta Pressão",
      "preco": 450.00,
      "quantidade_estoque": 3,
      "disponivel": true
    },
    {
      "id_produto": 12346,
      "nome_produto": "Motor Elétrico Industrial",
      "preco": 1250.50,
      "quantidade_estoque": 12,
      "disponivel": true
    },
    {
      "id_produto": 12347,
      "nome_produto": "Válvula Reguladora de Fluxo",
      "preco": 89.90,
      "quantidade_estoque": 2,
      "disponivel": true
    },
    {
      "id_produto": 12348,
      "nome_produto": "Painel de Controle Digital",
      "preco": 820.00,
      "quantidade_estoque": 8,
      "disponivel": true
    }
  ]
  ''';

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  Future<void> _carregarProdutos() async {
    setState(() {
      _isLoading = true;
    });

    
    await Future.delayed(const Duration(seconds: 1));

    try {
      final List<dynamic> jsonList = jsonDecode(_jsonRawData);
      final List<Produto> carregados =
          jsonList.map((item) => Produto.fromJson(item)).toList();

      setState(() {
        _produtos = carregados;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar dados: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo Dinâmico'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _carregarProdutos,
            tooltip: 'Recarregar',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _produtos.isEmpty
              ? const Center(
                  child: Text('Nenhum produto encontrado.'),
                )
              : ListView.builder(
                  itemCount: _produtos.length,
                  itemBuilder: (context, index) {
                    return ProdutoCard(produto: _produtos[index]);
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _carregarProdutos,
        tooltip: 'Recarregar',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}