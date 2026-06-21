import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? height;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      height: height,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.image_not_supported,
          size: height != null ? height! * 0.3 : 48,
        );
      },
    );
  }
}
