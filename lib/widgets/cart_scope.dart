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

  @override
  bool updateShouldNotify(CartScope oldWidget) {
    return cartCount != oldWidget.cartCount;
  }
}
