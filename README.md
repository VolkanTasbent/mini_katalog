# Mini Katalog Uygulaması

Flutter eğitimi kapsamında geliştirilen basit bir ürün katalog uygulamasıdır. Ana sayfa, ürün listesi ve ürün detayı ekranlarından oluşur; sayfa geçişleri, JSON veri modelleme, GridView listeleme ve basit sepet simülasyonu içerir.

**Repository:** https://github.com/VolkanTasbent/mini_katalog

## Kullanılan Flutter Sürümü

- Flutter 3.24.4
- Dart 3.5.4

## Özellikler

- Ana sayfa ve banner görseli (`Image.asset`)
- API üzerinden ürün listesi (`https://wantapi.com/products.php`)
- JSON model (`fromJson` / `toJson`)
- GridView ile kart tabanlı ürün gösterimi
- Ürün detay sayfası (Route Arguments)
- Named Routes ve `MaterialPageRoute`
- Basit arama ve filtreleme
- Sepete ekleme simülasyonu (state güncelleme)

## Proje Yapısı

```
lib/
├── main.dart
├── models/
│   └── product.dart
├── screens/
│   ├── home_screen.dart
│   ├── product_list_screen.dart
│   └── product_detail_screen.dart
├── services/
│   ├── product_service.dart
│   ├── product_service_io.dart
│   └── product_service_web.dart
└── widgets/
    ├── cart_scope.dart
    ├── product_card.dart
    ├── product_image.dart
    ├── product_image_io.dart
    └── product_image_web.dart
```

## Çalıştırma Adımları

1. Flutter SDK'nın kurulu olduğundan emin olun:
   ```bash
   flutter doctor
   ```

2. Projeyi klonlayın:
   ```bash
   git clone https://github.com/VolkanTasbent/mini_katalog.git
   cd mini_katalog
   ```

3. Bağımlılıkları yükleyin:
   ```bash
   flutter pub get
   ```

4. Uygulamayı çalıştırın:

   **Android emülatör veya fiziksel cihaz (önerilen):**
   ```bash
   flutter run
   ```

   **Chrome (web):**
   ```bash
   flutter run -d web-server --web-port=8090 --web-hostname=127.0.0.1
   ```

> **Not:** Uygulama internet bağlantısı gerektirir. Ürün verileri API'den, banner görseli `assets/images/banner.png` dosyasından yüklenir.

## Ekran Görüntüleri

Aşağıdaki dosyaları `screenshots/` klasörüne ekleyin:

- `screenshots/home.png` — Ana sayfa
- `screenshots/products.png` — Ürün listesi
- `screenshots/detail.png` — Ürün detayı

## Veri Kaynağı

Bu proje eğitim amaçlıdır. Kullanılan API ve görseller gerçek bir e-ticaret altyapısını temsil etmez.

- Ürün API: https://wantapi.com/products.php
- Banner: https://wantapi.com/assets/banner.png
