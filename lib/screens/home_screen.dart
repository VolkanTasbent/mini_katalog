import 'package:flutter/material.dart';

import '../widgets/cart_scope.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Katalog'),
        centerTitle: true,
        actions: const [CartIconButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/banner.png',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    'Hoş Geldiniz',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'En yeni ürünleri keşfedin ve sepetinize ekleyin.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (cart.cartCount > 0) ...[
                    const SizedBox(height: 16),
                    Chip(
                      avatar: const Icon(Icons.shopping_cart, size: 18),
                      label: Text('Sepetinizde ${cart.cartCount} ürün var'),
                    ),
                  ],
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/products');
                      },
                      icon: const Icon(Icons.storefront),
                      label: const Text('Ürünleri Görüntüle'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
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
