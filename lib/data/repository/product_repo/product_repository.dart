import 'dart:convert';

import 'package:shopywell/data/provider/product/product_provider.dart';
import 'package:shopywell/domain/models/product/product_detail_model.dart';

class ProductRepository {
  final ProductProvider productProvider;

  ProductRepository({required this.productProvider});

  // Fetch all products
  Future<List<ProductDetailModel>> fetchProducts() async {
    try {
      final response = await productProvider.getProducts();

      try {
        final List<dynamic> jsonResp = jsonDecode(response);

        if (jsonResp.isEmpty) {
          throw "No products found";
        }

        List<ProductDetailModel> productList = jsonResp
            .map((json) =>
                ProductDetailModel.fromMap(json as Map<String, dynamic>))
            .toList();

        return productList;
      } catch (e) {
        print("Error while parsing JSON: $e");
        throw "Error parsing product data";
      }
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }
}
