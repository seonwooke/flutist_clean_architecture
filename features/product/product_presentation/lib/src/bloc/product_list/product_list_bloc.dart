import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_domain/product_domain.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc({required ProductRepository repository})
      : _getProducts = GetProducts(repository),
        super(const ProductListInitial()) {
    on<ProductListStarted>(_onStarted);
    on<ProductListRefreshed>(_onStarted);
  }

  final GetProducts _getProducts;

  Future<void> _onStarted(
    ProductListEvent event,
    Emitter<ProductListState> emit,
  ) async {
    emit(const ProductListLoading());
    try {
      final products = await _getProducts();
      emit(ProductListSuccess(products: products));
    } catch (e) {
      emit(ProductListFailure(message: e.toString()));
    }
  }
}
