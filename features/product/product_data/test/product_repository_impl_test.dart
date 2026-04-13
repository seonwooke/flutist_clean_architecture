import 'package:product_data/product_data.dart';
import 'package:test/test.dart';

void main() {
  group('ProductRepositoryImpl', () {
    late ProductRepositoryImpl repository;

    setUp(() {
      repository = const ProductRepositoryImpl();
    });

    group('getProducts', () {
      test('returns exactly 5 products', () async {
        final products = await repository.getProducts();
        expect(products.length, 5);
      });

      test('all products have unique ids', () async {
        final products = await repository.getProducts();
        final ids = products.map((p) => p.id).toSet();
        expect(ids.length, products.length);
      });

      test('all products have non-empty name and description', () async {
        final products = await repository.getProducts();
        for (final product in products) {
          expect(product.name, isNotEmpty);
          expect(product.description, isNotEmpty);
        }
      });

      test('all products have positive price', () async {
        final products = await repository.getProducts();
        for (final product in products) {
          expect(product.price, greaterThan(0));
        }
      });

      test('returns consistent result on repeated calls', () async {
        final first = await repository.getProducts();
        final second = await repository.getProducts();
        expect(first, equals(second));
      });
    });

    group('getProductById', () {
      test('returns product with matching id', () async {
        final product = await repository.getProductById('1');
        expect(product.id, '1');
      });

      test('can retrieve all 5 products by id', () async {
        for (var i = 1; i <= 5; i++) {
          final product = await repository.getProductById('$i');
          expect(product.id, '$i');
        }
      });

      test('product from getProductById matches product from getProducts',
          () async {
        final all = await repository.getProducts();
        final byId = await repository.getProductById('3');
        expect(byId, equals(all.firstWhere((p) => p.id == '3')));
      });

      test('throws StateError for unknown id', () async {
        expect(
          () => repository.getProductById('999'),
          throwsStateError,
        );
      });
    });
  });
}
