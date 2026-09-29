
import 'package:bjio/common/bottomNav_bar_page.dart';
import 'package:bjio/models/product_model.dart';

import 'package:bjio/profile/edit_profile_page.dart';
import 'package:bjio/profile/favourite_page.dart';
import 'package:bjio/profile/help_support_page.dart';
import 'package:bjio/profile/notifications_page.dart';
import 'package:bjio/profile/profile_page.dart';
import 'package:bjio/profile/settings_page.dart';

import 'package:bjio/screens/cart_page.dart';
import 'package:bjio/screens/home_page.dart';
import 'package:bjio/screens/product_deatails_page.dart';
import 'package:bjio/screens/search_page.dart';

import 'package:go_router/go_router.dart';

class AppRouters {
  static final GoRouter appRouter = GoRouter(
    initialLocation: '/',

    routes: [
      // =====================================================
      // BOTTOM NAVIGATION
      // =====================================================

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BottomNavbarpage(
            navigationShell: navigationShell,
          );
        },

        branches: [
          // =================================================
          // HOME
          // =================================================

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'homePage',
                path: '/',
                builder: (context, state) {
                  return const HomePage();
                },
              ),
            ],
          ),

          // =================================================
          // SEARCH
          // =================================================

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'search',
                path: '/search',
                builder: (context, state) {
                  final products =
                      state.extra as List<ProductModel>? ?? [];

                  return SearchPage(
                    products: products,
                  );
                },
              ),
            ],
          ),

          // =================================================
          // CART
          // =================================================

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'cart',
                path: '/cart',
                builder: (context, state) {
                  return const CartPage();
                },
              ),
            ],
          ),

          // =================================================
          // PROFILE
          // =================================================

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'profile',
                path: '/profile',

                builder: (context, state) {
                  return const ProfilePage();
                },

                routes: [
                  // SETTINGS
                  GoRoute(
                    name: 'settings',
                    path: 'settings',
                    builder: (context, state) {
                      return const SettingsPage();
                    },
                  ),

                  // EDIT PROFILE
                  GoRoute(
                    name: 'editProfile',
                    path: 'edit-profile',
                    builder: (context, state) {
                      return const EditProfilePage();
                    },
                  ),

                  // HELP & SUPPORT
                  GoRoute(
                    name: 'helpSupport',
                    path: 'help-support',
                    builder: (context, state) {
                      return const HelpSupportPage();
                    },
                  ),

                  // FAVORITES
                  GoRoute(
                    name: 'favorites',
                    path: 'favorites',
                    builder: (context, state) {
                      return const FavoritesPage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // =====================================================
      // NOTIFICATIONS
      // =====================================================

      GoRoute(
        name: 'notifications',
        path: '/notifications',
        builder: (context, state) {
          return const NotificationPage();
        },
      ),

      // =====================================================
      // PRODUCT DETAILS
      // =====================================================

      GoRoute(
        name: 'productDetailsPage',
        path: '/productDetailsPage',
        builder: (context, state) {
          final product =
              state.extra as ProductModel;

          return ProductDetailsPage(
            product: product,
          );
        },
      ),
    ],
  );
}

