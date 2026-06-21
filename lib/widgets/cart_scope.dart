import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

class CartScope extends InheritedWidget {
  final int cartCount;
  final List<CartItem> cartItems;
  final void Function(Product product) addToCart;
  final void Function(int index) removeFromCart;
  final VoidCallback clearCart;

  const CartScope({
    super.key,
    required this.cartCount,
    required this.cartItems,
    required this.addToCart,
    required this.removeFromCart,
    required this.clearCart,
    required super.child,
  });

  static CartScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope bulunamadı.');
    return scope!;
  }

  void addProductToCart(BuildContext context, Product product) {
    addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} sepete eklendi.'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Sepeti Gör',
          onPressed: () => openCart(context),
        ),
      ),
    );
  }

  static void openCart(BuildContext context) {
    Navigator.pushNamed(context, '/cart');
  }

  @override
  bool updateShouldNotify(CartScope oldWidget) {
    return cartCount != oldWidget.cartCount ||
        cartItems.length != oldWidget.cartItems.length;
  }
}

class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topRight,
        children: [
          IconButton(
            tooltip: 'Sepetim',
            onPressed: () => CartScope.openCart(context),
            icon: const Icon(Icons.shopping_cart),
          ),
          if (cart.cartCount > 0)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Text(
                  '${cart.cartCount}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
