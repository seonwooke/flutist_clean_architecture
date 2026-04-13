import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_domain/product_domain.dart';
import 'package:product_presentation/src/bloc/product_list/product_list_bloc.dart';
import 'package:product_presentation/src/bloc/product_list/product_list_event.dart';
import 'package:product_presentation/src/bloc/product_list/product_list_state.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('ProductListBloc', () {
    late MockProductRepository repository;

    final products = [
      const Product(id: '1', name: 'A', description: 'desc A', price: 10.0),
      const Product(id: '2', name: 'B', description: 'desc B', price: 20.0),
    ];

    setUp(() {
      repository = MockProductRepository();
    });

    test('initial state is ProductListInitial', () {
      expect(
        ProductListBloc(repository: repository).state,
        isA<ProductListInitial>(),
      );
    });

    blocTest<ProductListBloc, ProductListState>(
      'ProductListStarted emits [Loading, Success] with products',
      build: () {
        when(() => repository.getProducts()).thenAnswer((_) async => products);
        return ProductListBloc(repository: repository);
      },
      act: (bloc) => bloc.add(ProductListStarted()),
      expect: () => [
        isA<ProductListLoading>(),
        isA<ProductListSuccess>().having(
          (s) => s.products,
          'products',
          equals(products),
        ),
      ],
    );

    blocTest<ProductListBloc, ProductListState>(
      'ProductListStarted emits [Loading, Failure] when repository throws',
      build: () {
        when(() => repository.getProducts())
            .thenThrow(Exception('network error'));
        return ProductListBloc(repository: repository);
      },
      act: (bloc) => bloc.add(ProductListStarted()),
      expect: () => [
        isA<ProductListLoading>(),
        isA<ProductListFailure>().having(
          (s) => s.message,
          'message',
          contains('network error'),
        ),
      ],
    );

    blocTest<ProductListBloc, ProductListState>(
      'ProductListRefreshed emits [Loading, Success]',
      build: () {
        when(() => repository.getProducts()).thenAnswer((_) async => products);
        return ProductListBloc(repository: repository);
      },
      act: (bloc) => bloc.add(ProductListRefreshed()),
      expect: () => [
        isA<ProductListLoading>(),
        isA<ProductListSuccess>(),
      ],
    );

    blocTest<ProductListBloc, ProductListState>(
      'Success state contains empty list when repository returns none',
      build: () {
        when(() => repository.getProducts()).thenAnswer((_) async => []);
        return ProductListBloc(repository: repository);
      },
      act: (bloc) => bloc.add(ProductListStarted()),
      expect: () => [
        isA<ProductListLoading>(),
        isA<ProductListSuccess>().having(
          (s) => s.products,
          'products',
          isEmpty,
        ),
      ],
    );

    blocTest<ProductListBloc, ProductListState>(
      'each event triggers one repository call',
      build: () {
        when(() => repository.getProducts()).thenAnswer((_) async => products);
        return ProductListBloc(repository: repository);
      },
      act: (bloc) => bloc
        ..add(ProductListStarted())
        ..add(ProductListRefreshed()),
      verify: (_) => verify(() => repository.getProducts()).called(2),
    );
  });
}
