import 'package:mocktail/mocktail.dart';
import 'package:product_domain/product_domain.dart';
import 'package:test/test.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('GetProducts', () {
    late MockProductRepository repository;
    late GetProducts useCase;

    final products = [
      const Product(id: '1', name: 'A', description: 'desc', price: 10.0),
      const Product(id: '2', name: 'B', description: 'desc2', price: 20.0),
    ];

    setUp(() {
      repository = MockProductRepository();
      useCase = GetProducts(repository);
    });

    test('delegates to repository.getProducts and returns result', () async {
      when(() => repository.getProducts()).thenAnswer((_) async => products);

      final result = await useCase();

      expect(result, equals(products));
      verify(() => repository.getProducts()).called(1);
    });

    test('returns empty list when repository returns empty', () async {
      when(() => repository.getProducts()).thenAnswer((_) async => []);

      final result = await useCase();

      expect(result, isEmpty);
    });

    test('propagates exception from repository', () {
      when(() => repository.getProducts()).thenThrow(Exception('network error'));

      expect(() => useCase(), throwsException);
    });

    test('calls repository exactly once per invocation', () async {
      when(() => repository.getProducts()).thenAnswer((_) async => products);

      await useCase();
      await useCase();

      verify(() => repository.getProducts()).called(2);
    });
  });
}
