import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:formflutterapp/src/models/product_model.dart';

class ProductsProvider {
  final String _url = 'https://flutter-form-project.firebaseio.com';

  // Method that creates a product in the database.
  Future<bool> createProduct(ProductModel product) async {
    final url = '${this._url}/products.json';

    final response = await http.post(url, body: productModelToJson(product));

    final decodedData = json.decode(response.body);

    print(decodedData);

    return true;
  }

  // Method that gets the list of products.
  Future<List<ProductModel>> getProducts() async {
    final url = '${this._url}/products.json';

    final response = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<ProductModel> products = new List();

    if (decodedData == null) {
      return [];
    }

    decodedData.forEach((id, prod) {
      final auxProduct = ProductModel.fromJson(prod);
      auxProduct.id = id;

      products.add(auxProduct);
    });

    return products;
  }

  // Method that deletes a product from the database.
  Future<bool> deleteProduct(String id) async {
    final url = '${this._url}/products/$id.json';

    final response = await http.delete(url);

    return true;
  }

  // Method that updates a product from the database.
  Future<bool> editProduct(ProductModel product) async {
    final url = '${this._url}/products/${product.id}.json';

    final response = await http.put(url, body: productModelToJson(product));

    final decodedData = json.decode(response.body);

    print(decodedData);

    return true;
  }
}