import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_domain/product_domain.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc({required ProductRepository repository})
      : _getProductDetail = GetProductDetail(repository),
        super(const ProductDetailInitial()) {
    on<ProductDetailStarted>(_onStarted);
  }

  final GetProductDetail _getProductDetail;

  Future<void> _onStarted(
    ProductDetailStarted event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(const ProductDetailLoading());
    try {
      final product = await _getProductDetail(event.productId);
      emit(ProductDetailSuccess(product: product));
    } catch (e) {
      emit(ProductDetailFailure(message: e.toString()));
    }
  }
}
