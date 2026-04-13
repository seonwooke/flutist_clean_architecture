import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';

class ProductListBloc
    extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(const ProductListInitial()) {
    on<ProductListStarted>(_onStarted);
  }

  Future<void> _onStarted(
    ProductListStarted event,
    Emitter<ProductListState> emit,
  ) async {
    // TODO: implement
  }
}