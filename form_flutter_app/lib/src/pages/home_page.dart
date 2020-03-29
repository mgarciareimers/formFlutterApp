import 'package:flutter/material.dart';

import 'package:formflutterapp/src/blocs/provider.dart';
import 'package:formflutterapp/src/models/product_model.dart';
import 'package:formflutterapp/src/providers/products_provider.dart';

class HomePage extends StatelessWidget {
  final productsProvider = new ProductsProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar:  AppBar(
        title: Text('Home Page'),
      ),
      body: this._createProductList(),
      floatingActionButton: this._createButton(context),
    );
  }

  // Method that creates the product list.
  Widget _createProductList() {
    return FutureBuilder(
      future: this.productsProvider.getProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          return Container();
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  // Method that creates the add product floating action button.
  Widget _createButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'product'),
    );
  }
}
