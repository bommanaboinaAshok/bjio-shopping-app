/*
"id": 1,
      "products": [
        {
          "id": 144,
          "title": "Cricket Helmet",
          "price": 44.99,
          "quantity": 4,
          "total": 179.96,
          "discountPercentage": 11.47,
          "discountedTotal": 159.32,
          "thumbnail": "https://cdn.dummyjson.com/products/images/sports-accessories/Cricket%20Helmet/thumbnail.png"
        },
 */
// create variables

class ProductModel {
  final int id;
  final String title;
  final double price;
   double quantity;
  final double total;
  final double discountPercentage;
  final double discountedTotal;
  final String thumbnail;

  // create obj for class instance

  ProductModel.fromJson({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });

 factory ProductModel.json(Map<String, dynamic> map) {
    return ProductModel.fromJson(
      id: map["id"] ?? 0,
      title: map["title"] ?? "",
      price: (map["price"] as num).toDouble(),
      quantity: (map["quantity"] as num).toDouble(),
      total: (map["total"] as num).toDouble(),
      discountPercentage:
          (map["discountPercentage"] as num).toDouble(),
      discountedTotal:
          (map["discountedTotal"] as num).toDouble(),
      thumbnail: map["thumbnail"] ?? "",
    );
  }

  void add(ProductModel product) {}
}
