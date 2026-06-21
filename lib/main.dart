import 'package:flutter/material.dart';

import 'models/product.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/product_list_screen.dart';
import 'widgets/cart_scope.dart';

const Product _sampleDetailProduct = Product(
  id: 1,
  name: 'iPhone 15 Pro',
  tagline: 'Titanium. So strong. So Pro.',
  description:
      'The iPhone 15 Pro is the first iPhone to feature an aerospace-grade titanium design, making it lighter and more durable than ever before. It is powered by the groundbreaking A17 Pro chip.',
  price: r'$999',
  currency: 'USD',
  image: 'https://wantapi.com/assets/images/iphone.png',
  specs: {
    'chip': 'A17 Pro',
    'material': 'Titanium',
    'camera': '48MP Main',
  },
);

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatefulWidget {
  const MiniKatalogApp({super.key});

  @override
  State<MiniKatalogApp> createState() => _MiniKatalogAppState();
}

class _MiniKatalogAppState extends State<MiniKatalogApp> {
  int _cartCount = 0;

  void _addToCart() {
    setState(() => _cartCount++);
  }

  @override
  Widget build(BuildContext context) {
    return CartScope(
      cartCount: _cartCount,
      addToCart: _addToCart,
      child: MaterialApp(
        title: 'Mini Katalog',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: true),
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/products': (context) => const ProductListScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/detail') {
            final product = settings.arguments is Product
                ? settings.arguments as Product
                : _sampleDetailProduct;
            return MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            );
          }
          return null;
        },
      ),
    );
  }
}
