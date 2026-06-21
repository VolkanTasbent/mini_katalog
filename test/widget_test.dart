import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mini_katalog/main.dart';

void main() {
  testWidgets('Ana sayfa yüklenir', (WidgetTester tester) async {
    await tester.pumpWidget(const MiniKatalogApp());

    expect(find.text('Mini Katalog'), findsOneWidget);
    expect(find.text('Ürünleri Görüntüle'), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
  });
}
