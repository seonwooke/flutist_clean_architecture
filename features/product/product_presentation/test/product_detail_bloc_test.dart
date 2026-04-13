import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_domain/product_domain.dart';
import 'package:product_presentation/src/bloc/product_detail/product_detail_bloc.dart';
import 'package:product_presentation/src/bloc/product_detail/product_detail_event.dart';
import 'package:product_presentation/src/bloc/product_detail/product_detail_state.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('ProductDetailBloc', () {
    late MockProductRepository repository;

    const product = Product(
      id: '1',
      name: 'Wireless Headphones',
      description: 'Premium sound quality.',
      price: 79.99,
    );

    setUp(() {
      repository = MockProductRepository();
    });

    test('initial state is ProductDetailInitial', () {
      expect(
        ProductDetailBloc(repository: repository).state,
        isA<ProductDetailInitial>(),
      );
    });

    blocTest<ProductDetailBloc, ProductDetailState>(
      'ProductDetailStarted emits [Loading, Success] with product',
      build: () {
        when(() => repository.getProductById('1'))
            .thenAnswer((_) async => product);
        return ProductDetailBloc(repository: repository);
      },
      act: (bloc) => bloc.add(ProductDetailStarted('1')),
      expect: () => [
        isA<ProductDetailLoading>(),
        isA<ProductDetailSuccess>().having(
          (s) => s.product,
          'product',
          equals(product),
        ),
      ],
    );

    blocTest<ProductDetailBloc, ProductDetailState>(
      'ProductDetailStarted emits [Loading, Failure] when repository throws',
      build: () {
        when(() => repository.getProductById(any()))
            .thenThrow(StateError('No element'));
        return ProductDetailBloc(repository: repository);
      },
      act: (bloc) => bloc.add(ProductDetailStarted('999')),
      expect: () => [
        isA<ProductDetailLoading>(),
        isA<ProductDetailFailure>(),
      ],
    );

    blocTest<ProductDetailBloc, ProductDetailState>(
      'Failure state contains error message',
      build: () {
        when(() => repository.getProductById(any()))
            .thenThrow(Exception('timeout'));
        return ProductDetailBloc(repository: repository);
      },
      act: (bloc) => bloc.add(ProductDetailStarted('1')),
      expect: () => [
        isA<ProductDetailLoading>(),
        isA<ProductDetailFailure>().having(
          (s) => s.message,
          'message',
          contains('timeout'),
        ),
      ],
    );

    blocTest<ProductDetailBloc, ProductDetailState>(
      'passes correct id to repository',
      build: () {
        when(() => repository.getProductById('3'))
            .thenAnswer((_) async => product);
        return ProductDetailBloc(repository: repository);
      },
      act: (bloc) => bloc.add(ProductDetailStarted('3')),
      verify: (_) {
        verify(() => repository.getProductById('3')).called(1);
        verifyNever(() => repository.getProductById('1'));
      },
    );
  });
}
