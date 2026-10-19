import 'package:flutter/material.dart';

import '../models/noticia_model.dart';
import '../services/noticia_service.dart';
import 'detalhe_noticia_screen.dart';

class FeedNoticiasScreen extends StatefulWidget {
  const FeedNoticiasScreen({super.key});

  @override
  State<FeedNoticiasScreen> createState() => _FeedNoticiasScreenState();
}

class _FeedNoticiasScreenState extends State<FeedNoticiasScreen> {
  final _service = NoticiaService();
  List<NoticiaModel> _noticias = [];
  List<NoticiaModel> _noticiasFiltradas = [];
  bool _carregando = true;
  String? _erro;

  final TextEditingController _buscaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarFeed();
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  Future<void> _carregarFeed({bool simularErro = false}) async {
    setState(() {
      _carregando = true;
      _erro = null;
    });

    try {
      final lista = await _service.buscarNoticias(simularErro: simularErro);
      setState(() {
        _noticias = lista;
        _noticiasFiltradas = lista;
        _buscaController.clear();
      });
    } catch (e) {
      setState(() {
        _erro = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  void _filtrarNoticias(String texto) {
    setState(() {
      if (texto.isEmpty) {
        _noticiasFiltradas = _noticias;
      } else {
        _noticiasFiltradas = _noticias
            .where((n) => n.titulo.toLowerCase().contains(texto.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed de Notícias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Atualizar Feed',
            onPressed: () => _carregarFeed(simularErro: false),
          ),

          IconButton(
            icon: const Icon(Icons.bug_report, color: Colors.amber),
            tooltip: 'Simular Erro de Conexão',
            onPressed: () => _carregarFeed(simularErro: true),
          ),
        ],
      ),
      body: _buildConteudo(),
    );
  }

  Widget _buildConteudo() {
    if (_carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_erro != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 12),
              Text(
                _erro!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => _carregarFeed(simularErro: false),
                child: const Text('Tentar Novamente'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _buscaController,
            onChanged: _filtrarNoticias,
            decoration: InputDecoration(
              labelText: 'Filtrar notícias por título',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),

        Expanded(
          child: _noticiasFiltradas.isEmpty
              ? const Center(child: Text('Nenhuma notícia encontrada.'))
              : ListView.builder(
                  itemCount: _noticiasFiltradas.length,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, index) {
                    final noticia = _noticiasFiltradas[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(noticia.id.toString()),
                        ),
                        title: Text(
                          noticia.titulo,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          noticia.resumo,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalheNoticiaScreen(noticia: noticia),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
