import 'package:mocktail/mocktail.dart';
import 'package:product_domain/product_domain.dart';
import 'package:test/test.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('GetProductDetail', () {
    late MockProductRepository repository;
    late GetProductDetail useCase;

    const product = Product(
      id: '1',
      name: 'Wireless Headphones',
      description: 'Premium sound quality.',
      price: 79.99,
    );

    setUp(() {
      repository = MockProductRepository();
      useCase = GetProductDetail(repository);
    });

    test('delegates to repository.getProductById with given id', () async {
      when(() => repository.getProductById('1'))
          .thenAnswer((_) async => product);

      final result = await useCase('1');

      expect(result, equals(product));
      verify(() => repository.getProductById('1')).called(1);
    });

    test('passes the exact id to repository', () async {
      when(() => repository.getProductById('42'))
          .thenAnswer((_) async => product);

      await useCase('42');

      verify(() => repository.getProductById('42')).called(1);
      verifyNever(() => repository.getProductById('1'));
    });

    test('propagates StateError when product not found', () {
      when(() => repository.getProductById(any()))
          .thenThrow(StateError('No element'));

      expect(() => useCase('999'), throwsStateError);
    });

    test('propagates generic exception from repository', () {
      when(() => repository.getProductById(any()))
          .thenThrow(Exception('network error'));

      expect(() => useCase('1'), throwsException);
    });
  });
}
