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
  const ProductListSuccess();
}

final class ProductListFailure extends ProductListState {
  final String message;
  const ProductListFailure(this.message);
}