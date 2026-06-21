import 'package:flutter/material.dart';

class CartScope extends InheritedWidget {
  final int cartCount;
  final VoidCallback addToCart;

  const CartScope({
    super.key,
    required this.cartCount,
    required this.addToCart,
    required super.child,
  });

  static CartScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope bulunamadı.');
    return scope!;
  }

  void addProductToCart(BuildContext context, String productName) {
    addToCart();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$productName sepete eklendi.'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  bool updateShouldNotify(CartScope oldWidget) {
    return cartCount != oldWidget.cartCount;
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
            tooltip: 'Sepet',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Sepetinizde ${cart.cartCount} ürün var.'),
                ),
              );
            },
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
