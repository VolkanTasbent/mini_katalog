// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

final Set<String> _registeredViews = <String>{};

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

  String get _viewType => 'product-image-${imageUrl.hashCode}';

  String get _objectFit {
    switch (fit) {
      case BoxFit.cover:
        return 'cover';
      case BoxFit.fill:
        return 'fill';
      case BoxFit.fitWidth:
        return 'scale-down';
      case BoxFit.fitHeight:
        return 'scale-down';
      case BoxFit.none:
        return 'none';
      case BoxFit.scaleDown:
        return 'scale-down';
      case BoxFit.contain:
        return 'contain';
    }
  }

  void _ensureRegistered() {
    if (_registeredViews.contains(_viewType)) return;
    _registeredViews.add(_viewType);

    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final image = html.ImageElement()
        ..src = imageUrl
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = _objectFit
        ..style.pointerEvents = 'none';

      return image;
    });
  }

  @override
  Widget build(BuildContext context) {
    _ensureRegistered();

    return SizedBox(
      height: height,
      width: double.infinity,
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
