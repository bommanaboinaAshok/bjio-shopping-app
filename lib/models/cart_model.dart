/*
"id": 1,
List<productModel> products,
 "total": 4794.8,
      "discountedTotal": 4288.95,
      "userId": 142,
      "totalProducts": 5,
      "totalQuantity": 20
 */

import 'package:bjio/models/product_model.dart';

class CartModel {
  final int id;
  final List<ProductModel> products;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  // Create obj instance of class

  CartModel.fromCart({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory CartModel.toCart(Map<String, dynamic> map) {
    return CartModel.fromCart(
      id: map["id"] ?? 0,

      products: (map["products"] as List)
          .map(
            (product) => ProductModel.json(product),
          )
          .toList(),

      total: (map["total"] as num).toDouble(),

      discountedTotal:
          (map["discountedTotal"] as num).toDouble(),

      userId: map["userId"] ?? 0,

      totalProducts: map["totalProducts"] ?? 0,

      totalQuantity: map["totalQuantity"] ?? 0,
    );
  }
}
