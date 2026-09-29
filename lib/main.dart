
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bjio/provider/cart_provider.dart';
import 'package:bjio/provider/favourite_provider.dart';
import 'package:bjio/provider/notification_provider.dart';

import 'package:bjio/routers/app_routers.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // CART
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),

        // FAVORITES
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(),
        ),

        // NOTIFICATIONS
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      // LIGHT THEME
      theme: ThemeData.light(
        useMaterial3: true,
      ),

      // DARK THEME
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),

      // FOLLOW SYSTEM THEME
      themeMode: ThemeMode.system,

      routerConfig: AppRouters.appRouter,
    );
  }
}

