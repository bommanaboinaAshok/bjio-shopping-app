import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bjio/provider/favourite_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider =
        context.watch<FavoriteProvider>();

    final favorites =
        favoriteProvider.favoriteProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
      ),

      body: favorites.isEmpty
          ? const Center(
              child: Text(
                "No Favorite Products",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];

                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: ListTile(
                    leading: Image.network(
                      product.thumbnail,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),

                    title: Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    subtitle: Text(
                      "\$${product.price}",
                    ),

                    trailing: IconButton(
                      onPressed: () {
                        favoriteProvider
                            .removeFromFavorites(product);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}