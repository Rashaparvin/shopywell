import 'package:http/http.dart' as http;

class ProductProvider {
  Future<String> getProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode != 200) {
        throw Exception('Unexpected error occurred.');
      }
      return response.body;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }
}
