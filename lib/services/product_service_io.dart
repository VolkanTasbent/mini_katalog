import 'dart:convert';
import 'dart:io';

import '../models/product.dart';

class ProductService {
  static const String productsUrl = 'https://wantapi.com/products.php';
  static const String bannerUrl = 'https://wantapi.com/assets/banner.png';

  Future<List<Product>> fetchProducts() async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse(productsUrl));
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      if (response.statusCode != 200) {
        throw HttpException('Sunucu hatası: ${response.statusCode}');
      }

      return _parseProducts(body);
    } finally {
      client.close();
    }
  }

  List<Product> _parseProducts(String body) {
    final decoded = json.decode(body) as Map<String, dynamic>;
    final data = decoded['data'] as List<dynamic>;

    return data
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
