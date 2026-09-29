
import 'dart:convert';

import 'package:bjio/models/cart_model.dart';
import 'package:bjio/models/product_model.dart';
import 'package:bjio/provider/favourite_provider.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> myproduct = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  // =====================================================
  // GET PRODUCTS
  // =====================================================

  Future<void> getData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://dummyjson.com/carts',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(response.body);

        final List mycart = data["carts"];

        final List<CartModel> myCarts = mycart
            .map(
              (cart) => CartModel.toCart(cart),
            )
            .toList();

        final List<ProductModel> products = [];

        for (final CartModel cart in myCarts) {
          products.addAll(cart.products);
        }

        if (!mounted) return;

        setState(() {
          myproduct = products;
          isLoading = false;
        });
      } else {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      debugPrint("Error: $e");
    }
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =================================================
      // APP BAR
      // =================================================

      appBar: AppBar(
        elevation: 0,

        title: const Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Text(
              "Online Shop",

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            Text(
              "Find your favorite products",

              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),

        actions: [
          // SEARCH
          IconButton(
            onPressed: () {
              context.pushNamed(
                'search',
                extra: myproduct,
              );
            },

            icon: const Icon(
              Icons.search,
            ),
          ),

          // CART
          IconButton(
            onPressed: () {
              context.pushNamed('cart');
            },

            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),

          // NOTIFICATIONS
          IconButton(
            onPressed: () {
              context.pushNamed(
                'notifications',
              );
            },

            icon: const Icon(
              Icons.notifications_none,
            ),
          ),

          const SizedBox(
            width: 8,
          ),
        ],
      ),

      backgroundColor:
          Colors.blue.shade50,

      // =================================================
      // BODY
      // =================================================

      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : myproduct.isEmpty
              ? const Center(
                  child: Text(
                    "No products found",

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                )
              : LayoutBuilder(
                  builder: (
                    context,
                    constraints,
                  ) {
                    // ===================================
                    // RESPONSIVE COLUMNS
                    // ===================================

                    int columns = 2;

                    if (constraints.maxWidth >=
                        1200) {
                      columns = 5;
                    } else if (constraints.maxWidth >=
                        900) {
                      columns = 4;
                    } else if (constraints.maxWidth >=
                        600) {
                      columns = 3;
                    }

                    // ===================================
                    // RESPONSIVE PADDING
                    // ===================================

                    double padding = 12;

                    if (constraints.maxWidth >=
                        900) {
                      padding = 24;
                    }

                    return GridView.builder(
                      padding:
                          EdgeInsets.all(
                        padding,
                      ),

                      itemCount:
                          myproduct.length,

                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            columns,

                        crossAxisSpacing: 12,

                        mainAxisSpacing: 12,

                        childAspectRatio:
                            0.65,
                      ),

                      itemBuilder: (
                        context,
                        index,
                      ) {
                        final product =
                            myproduct[index];

                        return _productCard(
                          context,
                          product,
                        );
                      },
                    );
                  },
                ),
    );
  }

  // =====================================================
  // PRODUCT CARD
  // =====================================================

  Widget _productCard(
    BuildContext context,
    ProductModel product,
  ) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          'productDetailsPage',
          extra: product,
        );
      },

      borderRadius:
          BorderRadius.circular(18),

      child: Card(
        elevation: 4,

        clipBehavior:
            Clip.antiAlias,

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(18),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // ===========================================
            // PRODUCT IMAGE
            // ===========================================

            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width:
                        double.infinity,

                    child: Image.network(
                      product.thumbnail,

                      fit: BoxFit.cover,

                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return const Center(
                          child: Icon(
                            Icons
                                .image_not_supported,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),

                  // =====================================
                  // FAVORITE BUTTON
                  // =====================================

                  Positioned(
                    top: 8,
                    right: 8,

                    child: Consumer<
                        FavoriteProvider>(
                      builder: (
                        context,
                        favoriteProvider,
                        child,
                      ) {
                        final isFavorite =
                            favoriteProvider
                                .isFavorite(
                          product,
                        );

                        return Material(
                          color: Colors.white,
                          shape:
                              const CircleBorder(),

                          child: IconButton(
                            padding:
                                EdgeInsets.zero,

                            constraints:
                                const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),

                            onPressed: () {
                              if (isFavorite) {
                                favoriteProvider
                                    .removeFromFavorites(
                                  product,
                                );
                              } else {
                                favoriteProvider
                                    .addToFavorites(
                                  product,
                                );
                              }
                            },

                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons
                                      .favorite_border,

                              color: isFavorite
                                  ? Colors.red
                                  : Colors.black,

                              size: 22,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ===========================================
            // PRODUCT INFORMATION
            // ===========================================

            Padding(
              padding:
                  const EdgeInsets.all(10),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  // TITLE
                  Text(
                    product.title,

                    maxLines: 2,

                    overflow:
                        TextOverflow.ellipsis,

                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,

                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  // =====================================
                  // PRICE + QUANTITY
                  // =====================================

                  Row(
                    children: [
                      // PRICE
                      Expanded(
                        child: Text(
                          "\$${product.price}",

                          maxLines: 1,

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,

                            fontSize: 18,
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 6,
                      ),

                      // QUANTITY
                      Flexible(
                        child: Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 7,
                            vertical: 4,
                          ),

                          decoration:
                              BoxDecoration(
                            color: Colors
                                .blue
                                .shade100,

                            borderRadius:
                                BorderRadius
                                    .circular(
                              8,
                            ),
                          ),

                          child: Text(
                            "Qty ${product.quantity}",

                            maxLines: 1,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style: TextStyle(
                              color: Colors
                                  .blue
                                  .shade800,

                              fontSize: 11,

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  // =====================================
                  // VIEW DETAILS
                  // =====================================

                  SizedBox(
                    width:
                        double.infinity,

                    child:
                        OutlinedButton(
                      onPressed: () {
                        context.pushNamed(
                          'productDetailsPage',
                          extra: product,
                        );
                      },

                      style:
                          OutlinedButton
                              .styleFrom(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          vertical: 10,
                        ),
                      ),

                      child:
                          const Text(
                        "View Details",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

