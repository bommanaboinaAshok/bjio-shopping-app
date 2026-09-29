
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:bjio/models/product_model.dart';
import 'package:bjio/provider/cart_provider.dart';
import 'package:bjio/provider/favourite_provider.dart';

class SearchPage extends StatefulWidget {
  final List<ProductModel> products;

  const SearchPage({
    super.key,
    required this.products,
  });

  @override
  State<SearchPage> createState() =>
      _SearchPageState();
}

class _SearchPageState
    extends State<SearchPage> {
  final TextEditingController searchController =
      TextEditingController();

  List<ProductModel> searchResults = [];

  @override
  void initState() {
    super.initState();

    searchResults = widget.products;
  }

  // =====================================================
  // SEARCH PRODUCTS
  // =====================================================

  void searchProducts(String value) {
    final query = value.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        searchResults = widget.products;
      } else {
        searchResults = widget.products
            .where(
              (product) => product.title
                  .toLowerCase()
                  .contains(query),
            )
            .toList();
      }
    });
  }

  // =====================================================
  // CLEAR SEARCH
  // =====================================================

  void clearSearch() {
    searchController.clear();

    setState(() {
      searchResults = widget.products;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Products",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          // =================================================
          // SEARCH BOX
          // =================================================

          Padding(
            padding: const EdgeInsets.all(16),

            child: TextField(
              controller: searchController,

              onChanged: searchProducts,

              decoration: InputDecoration(
                hintText: "Search products...",

                prefixIcon: const Icon(
                  Icons.search,
                ),

                suffixIcon:
                    searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: clearSearch,

                            icon: const Icon(
                              Icons.clear,
                            ),
                          )
                        : null,

                filled: true,

                fillColor: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),
          ),

          // =================================================
          // RESULT COUNT
          // =================================================

          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),

            child: Align(
              alignment:
                  Alignment.centerLeft,

              child: Text(
                "${searchResults.length} products found",

                style: TextStyle(
                  color: Colors.grey.shade600,

                  fontWeight:
                      FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // =================================================
          // PRODUCTS
          // =================================================

          Expanded(
            child: searchResults.isEmpty
                ? _emptySearch()
                : _responsiveGrid(),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // EMPTY SEARCH
  // =====================================================

  Widget _emptySearch() {
    return const Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          Icon(
            Icons.search_off,
            size: 70,
            color: Colors.grey,
          ),

          SizedBox(height: 10),

          Text(
            "No products found",

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // RESPONSIVE GRID
  // =====================================================

  Widget _responsiveGrid() {
    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        int crossAxisCount = 2;

        // MOBILE
        if (constraints.maxWidth < 600) {
          crossAxisCount = 2;
        }

        // TABLET
        else if (constraints.maxWidth < 900) {
          crossAxisCount = 3;
        }

        // DESKTOP
        else if (constraints.maxWidth < 1200) {
          crossAxisCount = 4;
        }

        // LARGE DESKTOP
        else {
          crossAxisCount = 5;
        }

        double padding = 16;

        if (constraints.maxWidth >= 900) {
          padding = 24;
        }

        return GridView.builder(
          padding:
              EdgeInsets.all(padding),

          itemCount:
              searchResults.length,

          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                crossAxisCount,

            crossAxisSpacing: 12,

            mainAxisSpacing: 12,

            childAspectRatio: 0.65,
          ),

          itemBuilder: (
            context,
            index,
          ) {
            final product =
                searchResults[index];

            return _productCard(
              context,
              product,
            );
          },
        );
      },
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
        elevation: 3,

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
            // =================================================
            // IMAGE + FAVORITE
            // =================================================

            Expanded(
              child: Stack(
                children: [
                  // PRODUCT IMAGE
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

                  // =================================================
                  // FAVORITE
                  // =================================================

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

            // =================================================
            // PRODUCT DETAILS
            // =================================================

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

                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  // PRICE
                  Text(
                    "\$${product.price}",

                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,

                    style:
                        const TextStyle(
                      fontSize: 17,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  // =================================================
                  // ADD TO CART
                  // =================================================

                  SizedBox(
                    width:
                        double.infinity,

                    child:
                        ElevatedButton(
                      onPressed: () {
                        context
                            .read<
                                CartProvider>()
                            .addToCart(
                              product,
                            );

                        ScaffoldMessenger
                                .of(
                          context,
                        ).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Added to cart",
                            ),
                          ),
                        );
                      },

                      style:
                          ElevatedButton
                              .styleFrom(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          vertical: 10,
                        ),
                      ),

                      child:
                          const Text(
                        "Add to Cart",
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

