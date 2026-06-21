import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import '../models/product.dart';

class ProductService {
  static const String productsUrl = 'https://wantapi.com/products.php';
  static const String bannerUrl = 'https://wantapi.com/assets/banner.png';

  Future<List<Product>> fetchProducts() async {
    final response = await html.HttpRequest.getString(productsUrl);
    return _parseProducts(response);
  }

  List<Product> _parseProducts(String body) {
    final decoded = json.decode(body) as Map<String, dynamic>;
    final data = decoded['data'] as List<dynamic>;

    return data
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
