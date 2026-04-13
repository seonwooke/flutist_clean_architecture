import 'package:bloc_test/bloc_test.dart';
import 'package:cart_domain/cart_domain.dart';
import 'package:cart_presentation/cart_presentation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  group('CartBloc', () {
    late MockCartRepository repository;

    const emptyCart = Cart(items: []);
    const item = CartItem(
      productId: 'p1',
      name: 'Widget',
      price: 10.0,
      quantity: 1,
    );
    const cartWithItem = Cart(items: [item]);

    setUpAll(() {
      registerFallbackValue(item);
    });

    setUp(() {
      repository = MockCartRepository();
    });

    test('initial state is CartInitial', () {
      expect(
        CartBloc(repository: repository).state,
        isA<CartInitial>(),
      );
    });

    blocTest<CartBloc, CartState>(
      'CartStarted emits [Loading, Success] with cart',
      build: () {
        when(() => repository.getCart()).thenAnswer((_) async => emptyCart);
        return CartBloc(repository: repository);
      },
      act: (bloc) => bloc.add(CartStarted()),
      expect: () => [
        isA<CartLoading>(),
        isA<CartSuccess>().having(
          (s) => s.cart,
          'cart',
          equals(emptyCart),
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'CartStarted emits [Loading, Failure] when repository throws',
      build: () {
        when(() => repository.getCart())
            .thenThrow(Exception('storage error'));
        return CartBloc(repository: repository);
      },
      act: (bloc) => bloc.add(CartStarted()),
      expect: () => [
        isA<CartLoading>(),
        isA<CartFailure>().having(
          (s) => s.message,
          'message',
          contains('storage error'),
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'CartItemAdded emits Success with updated cart',
      build: () {
        when(() => repository.addItem(any())).thenAnswer((_) async {});
        when(() => repository.getCart()).thenAnswer((_) async => cartWithItem);
        return CartBloc(repository: repository);
      },
      act: (bloc) => bloc.add(CartItemAdded(item)),
      expect: () => [
        isA<CartSuccess>().having(
          (s) => s.cart.items.length,
          'items count',
          1,
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'CartItemAdded emits Failure when addItem throws',
      build: () {
        when(() => repository.addItem(any()))
            .thenThrow(Exception('add failed'));
        return CartBloc(repository: repository);
      },
      act: (bloc) => bloc.add(CartItemAdded(item)),
      expect: () => [isA<CartFailure>()],
    );

    blocTest<CartBloc, CartState>(
      'CartItemRemoved emits Success with updated cart',
      build: () {
        when(() => repository.removeItem(any())).thenAnswer((_) async {});
        when(() => repository.getCart()).thenAnswer((_) async => emptyCart);
        return CartBloc(repository: repository);
      },
      act: (bloc) => bloc.add(CartItemRemoved('p1')),
      expect: () => [
        isA<CartSuccess>().having(
          (s) => s.cart.items,
          'items',
          isEmpty,
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'CartItemRemoved emits Failure when removeItem throws',
      build: () {
        when(() => repository.removeItem(any()))
            .thenThrow(Exception('remove failed'));
        return CartBloc(repository: repository);
      },
      act: (bloc) => bloc.add(CartItemRemoved('p1')),
      expect: () => [isA<CartFailure>()],
    );

    blocTest<CartBloc, CartState>(
      'CartCleared emits Success with empty cart',
      build: () {
        when(() => repository.clearCart()).thenAnswer((_) async {});
        when(() => repository.getCart()).thenAnswer((_) async => emptyCart);
        return CartBloc(repository: repository);
      },
      act: (bloc) => bloc.add(CartCleared()),
      expect: () => [
        isA<CartSuccess>().having(
          (s) => s.cart.items,
          'items',
          isEmpty,
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'CartCleared emits Failure when clearCart throws',
      build: () {
        when(() => repository.clearCart())
            .thenThrow(Exception('clear failed'));
        return CartBloc(repository: repository);
      },
      act: (bloc) => bloc.add(CartCleared()),
      expect: () => [isA<CartFailure>()],
    );

    blocTest<CartBloc, CartState>(
      'addItem calls repository with correct item',
      build: () {
        when(() => repository.addItem(any())).thenAnswer((_) async {});
        when(() => repository.getCart()).thenAnswer((_) async => cartWithItem);
        return CartBloc(repository: repository);
      },
      act: (bloc) => bloc.add(CartItemAdded(item)),
      verify: (_) => verify(() => repository.addItem(item)).called(1),
    );
  });
}
