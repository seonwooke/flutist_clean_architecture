import 'product.dart';
import 'product_repository.dart';

class GetProductDetail {
  const GetProductDetail(this._repository);

  final ProductRepository _repository;

  Future<Product> call(String id) => _repository.getProductById(id);
}
