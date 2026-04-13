import 'package:product_domain/product_domain.dart';

sealed class ProductListState {
  const ProductListState();
}

final class ProductListInitial extends ProductListState {
  const ProductListInitial();
}

final class ProductListLoading extends ProductListState {
  const ProductListLoading();
}

final class ProductListSuccess extends ProductListState {
  const ProductListSuccess({required this.products});
  final List<Product> products;
}

final class ProductListFailure extends ProductListState {
  const ProductListFailure({required this.message});
  final String message;
}
