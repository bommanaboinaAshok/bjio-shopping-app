import 'package:flutter/material.dart';
import 'package:bjio/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> _cartProducts = [];

  List<ProductModel> get cartProducts => _cartProducts;

  int get cartCount => _cartProducts.length;

  // Add product
  void addToCart(ProductModel product) {
    _cartProducts.add(product);

    notifyListeners();
  }

  // Remove product
  void removeFromCart(ProductModel product) {
    _cartProducts.remove(product);

    notifyListeners();
  }

  // Increase quantity
  void increaseQuantity(ProductModel product) {
    product.quantity++;

    notifyListeners();
  }

  // Decrease quantity
  void decreaseQuantity(ProductModel product) {
    if (product.quantity > 1) {
      product.quantity--;

      notifyListeners();
    }
  }

  // Total price
  double get totalPrice {
    double total = 0;

    for (ProductModel product in _cartProducts) {
      total += product.price * product.quantity;
    }

    return total;
  }

  // Clear cart
  void clearCart() {
    _cartProducts.clear();

    notifyListeners();
  }
}