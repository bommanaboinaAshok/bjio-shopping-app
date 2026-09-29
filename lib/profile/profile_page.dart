
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:bjio/provider/favourite_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ================= PROFILE HEADER =================

            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(
                Icons.person,
                size: 65,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Ashok",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "ashok@gmail.com",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 25),

            // ================= EDIT PROFILE =================

            _profileOption(
              context,
              icon: Icons.edit,
              title: "Edit Profile",
              subtitle: "Change your personal information",
              onTap: () {
                context.pushNamed('editProfile');
              },
            ),

            // ================= MY ORDERS =================

            _profileOption(
              context,
              icon: Icons.shopping_bag_outlined,
              title: "My Orders",
              subtitle: "View your previous orders",
              onTap: () {
                // TODO: Orders page
              },
            ),

            // ================= MY CART =================

            _profileOption(
              context,
              icon: Icons.shopping_cart_outlined,
              title: "My Cart",
              subtitle: "View items in your cart",
              onTap: () {
                context.pushNamed('cart');
              },
            ),

            // ================= FAVORITES =================

            Consumer<FavoriteProvider>(
              builder: (
                context,
                favoriteProvider,
                child,
              ) {
                return _profileOption(
                  context,
                  icon: Icons.favorite_border,
                  title: "Favorites",
                  subtitle:
                      "${favoriteProvider.favoriteCount} favorite products",
                  onTap: () {
                    context.pushNamed('favorites');
                  },
                );
              },
            ),

            // ================= SETTINGS =================

            _profileOption(
              context,
              icon: Icons.settings_outlined,
              title: "Settings",
              subtitle: "Manage app settings",
              onTap: () {
                context.pushNamed('settings');
              },
            ),

            // ================= HELP & SUPPORT =================

            _profileOption(
              context,
              icon: Icons.help_outline,
              title: "Help & Support",
              subtitle: "Get help with your account",
              onTap: () {
                context.pushNamed('helpSupport');
              },
            ),

            const SizedBox(height: 10),

            // ================= LOGOUT =================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),

              child: Card(
                elevation: 0,
                color: Colors.red.shade50,

                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.red.shade700,
                  ),

                  title: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.red.shade700,
                  ),

                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ================= REUSABLE PROFILE OPTION =================

  static Widget _profileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),

      child: Card(
        elevation: 1,

        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),

          // ICON
          leading: CircleAvatar(
            backgroundColor: Colors.blue.shade50,

            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),

          // TITLE
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          // SUBTITLE
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),

          // ARROW
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),

          // TAP
          onTap: onTap,
        ),
      ),
    );
  }

  // ================= LOGOUT DIALOG =================

  static void _showLogoutDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Logout",
          ),

          content: const Text(
            "Are you sure you want to logout?",
          ),

          actions: [
            // CANCEL
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                "Cancel",
              ),
            ),

            // LOGOUT
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Logged out",
                    ),
                  ),
                );
              },

              child: const Text(
                "Logout",
              ),
            ),
          ],
        );
      },
    );
  }
}

