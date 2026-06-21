import 'package:flutter/material.dart';

class CartScope extends InheritedWidget {
  final int cartCount;
  final List<String> cartItems;
  final void Function(String productName) addToCart;

  const CartScope({
    super.key,
    required this.cartCount,
    required this.cartItems,
    required this.addToCart,
    required super.child,
  });

  static CartScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope bulunamadı.');
    return scope!;
  }

  void addProductToCart(BuildContext context, String productName) {
    addToCart(productName);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$productName sepete eklendi.'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Sepeti Gör',
          onPressed: () => showCart(context),
        ),
      ),
    );
  }

  static void showCart(BuildContext context) {
    final cart = of(context);

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Sepetim',
                style: Theme.of(sheetContext).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (cart.cartItems.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'Sepetiniz boş.\nÜrün eklemek için "Sepete Ekle" butonunu kullanın.',
                    textAlign: TextAlign.center,
                  ),
                )
              else
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 240),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: cart.cartItems.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.shopping_bag_outlined),
                        title: Text(cart.cartItems[index]),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                'Toplam: ${cart.cartCount} ürün',
                style: Theme.of(sheetContext).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(sheetContext),
                child: const Text('Kapat'),
              ),
            ],
          ),
        );
      },
    );
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
            tooltip: 'Sepeti Aç',
            onPressed: () => CartScope.showCart(context),
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
