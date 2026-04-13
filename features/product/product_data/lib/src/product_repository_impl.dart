import 'package:product_domain/product_domain.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl();

  static const _products = [
    Product(
      id: '1',
      name: 'Wireless Headphones',
      description:
          'Premium sound quality with active noise cancellation. Up to 30 hours battery life.',
      price: 79.99,
    ),
    Product(
      id: '2',
      name: 'Mechanical Keyboard',
      description:
          'Tactile switches for a satisfying typing experience. RGB backlight.',
      price: 129.99,
    ),
    Product(
      id: '3',
      name: 'USB-C Hub',
      description:
          '7-in-1 hub with HDMI, USB 3.0, SD card reader, and 100W PD charging.',
      price: 39.99,
    ),
    Product(
      id: '4',
      name: 'Webcam 4K',
      description:
          'Crystal clear video calls with auto-focus and built-in microphone.',
      price: 89.99,
    ),
    Product(
      id: '5',
      name: 'Desk Lamp',
      description:
          'LED lamp with adjustable color temperature and brightness. USB charging port.',
      price: 34.99,
    ),
  ];

  @override
  Future<List<Product>> getProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _products;
  }

  @override
  Future<Product> getProductById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return _products.firstWhere((p) => p.id == id);
  }
}
