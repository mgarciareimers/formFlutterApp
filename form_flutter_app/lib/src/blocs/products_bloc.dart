import 'dart:io';
import 'package:formflutterapp/src/providers/products_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:formflutterapp/src/models/product_model.dart';

class ProductsBloc {
  final _productsController = BehaviorSubject<List<ProductModel>>();
  final _loadingController = BehaviorSubject<bool>();

  final _productsProvider = new ProductsProvider();

  // Get values from Stream.
  Stream<List<ProductModel>> get productsStream => this._productsController.stream;
  Stream<bool> get loadingStream => this._loadingController.stream;

  void createProduct(ProductModel product) async {
    this._loadingController.sink.add(true);
    await this._productsProvider.createProduct(product);
    this._loadingController.sink.add(false);
  }

  void getProducts() async {
    final products = await this._productsProvider.getProducts();
    this._productsController.sink.add(products);
  }

  Future<String> uploadImage(File picture) async {
    this._loadingController.sink.add(true);
    final pictureUrl = await this._productsProvider.uploadImage(picture);
    this._loadingController.sink.add(false);

    return pictureUrl;
  }

  void editProduct(ProductModel product) async {
    this._loadingController.sink.add(true);
    await this._productsProvider.editProduct(product);
    this._loadingController.sink.add(false);
  }

  void deleteProduct(String id) async {
    this._loadingController.sink.add(true);
    await this._productsProvider.deleteProduct(id);
    this._loadingController.sink.add(false);
  }

  // Close Stream Controllers.
  dispose() {
    this._productsController?.close();
    this._loadingController?.close();
  }
}