import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BrokenGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
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
                      imageUrl: 'https://picsum.photos/800/600?random=$i', 
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                     
                      memCacheWidth: 300, 
                    ),
                  ),
                  Text('Item $i'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}