import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BrokenListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('BOM — ListView.builder')),
        // 1. SingleChildScrollView + Column substituídos por ListView.builder
        body: ListView.builder(
          itemCount: 200, // Total de itens na lista
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.all(16), 
              child: Column(
                children: [
                  // 2. Image.network substituído por CachedNetworkImage
                  CachedNetworkImage(
                    imageUrl: 'https://picsum.photos/800/600?random=$i',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                    // Redimensionamento na memória
                    memCacheWidth: 400, 
                  ),
                  const SizedBox(height: 12), 
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