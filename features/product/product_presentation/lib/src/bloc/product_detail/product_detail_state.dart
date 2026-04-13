import 'package:product_domain/product_domain.dart';

sealed class ProductDetailState {
  const ProductDetailState();
}

final class ProductDetailInitial extends ProductDetailState {
  const ProductDetailInitial();
}

final class ProductDetailLoading extends ProductDetailState {
  const ProductDetailLoading();
}

final class ProductDetailSuccess extends ProductDetailState {
  const ProductDetailSuccess({required this.product});
  final Product product;
}

final class ProductDetailFailure extends ProductDetailState {
  const ProductDetailFailure({required this.message});
  final String message;
}
