import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

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
  
  // Method that uploads an image.
  Future<String> uploadImage(File picture) async {
    final url = Uri.parse("http://api.cloudinary.com/v1_1/dptixz77g/image/upload?upload_preset=ktw1tt8t");
    final mimeType = mime(picture.path).split('/');

    final uploadRequest = http.MultipartRequest('POST', url,);
    final file = await http.MultipartFile.fromPath('file', picture.path, contentType: MediaType(mimeType[0], mimeType[1]));
    uploadRequest.files.add(file);

    final streamResponse = await uploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      return null;
    }

    final decodedData = json.decode(response.body);

    return decodedData['secure_url'];
  }
}