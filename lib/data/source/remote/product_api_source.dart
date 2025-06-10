import 'package:cache_storage_demo/data/model/remote/product/product_response.dart';
import 'package:onix_flutter_core/onix_flutter_core.dart';

class ProductApiSource {
  Future<DataResponse<ProductResponse>> getProduct() async {
    await Future.delayed(const Duration(seconds: 2));
    final data = ProductResponse(
      id: 'product-1',
      name: 'Product 1',
      price: 10,
    );

    return DataResponse.success(data);
  }

  Future<DataResponse<ProductResponse>> getProductFailure() async {
    await Future.delayed(const Duration(seconds: 1));

    return DataResponse<ProductResponse>.notConnected();
  }
}
