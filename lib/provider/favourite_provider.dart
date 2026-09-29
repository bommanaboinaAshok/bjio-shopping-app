
import 'package:flutter/material.dart';
import 'package:bjio/models/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<ProductModel> _favoriteProducts = [];

  // Get favorite products
  List<ProductModel> get favoriteProducts => _favoriteProducts;

  // Favorite count
  int get favoriteCount => _favoriteProducts.length;

  // Add product to favorites
  void addToFavorites(ProductModel product) {
    if (!_favoriteProducts.contains(product)) {
      _favoriteProducts.add(product);

      notifyListeners();
    }
  }

  // Remove product from favorites
  void removeFromFavorites(ProductModel product) {
    _favoriteProducts.remove(product);

    notifyListeners();
  }

  // Check if product is favorite
  bool isFavorite(ProductModel product) {
    return _favoriteProducts.contains(product);
  }

  // Clear all favorites
  void clearFavorites() {
    _favoriteProducts.clear();

    notifyListeners();
  }
}

