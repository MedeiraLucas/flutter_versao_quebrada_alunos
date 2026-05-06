import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BrokenGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // A lista foi removida, pois o GridView.builder gerencia o índice nativamente
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('BOM — GridView.builder')),
        // 1. Trocado de GridView.count para GridView.builder (Lazy Loading)
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 200, // Define a quantidade total de itens aqui
          itemBuilder: (context, i) {
            return Container(
              margin: const EdgeInsets.all(8), // 3. Uso do 'const' para reduzir rebuilds
              color: Colors.pinkAccent,
              child: Column(
                children: [
                  Expanded(
                    // 2. Trocado Image.network por CachedNetworkImage
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/800/600?random=$i', // Adicionado random para evitar cache do mesmo frame para todos
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                      // Dica crucial: redimensiona a imagem na memória para economizar RAM
                      memCacheWidth: 300, 
                    ),
                  ),
                  Text('Item $i'), // 3. Texto reaproveita a variável 'i' do builder
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}