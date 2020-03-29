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
          final products = snapshot.data;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => this._createListItem(context, products[index]),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  // Method that creates the list item.
  Widget _createListItem(BuildContext context, ProductModel product) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) => this.productsProvider.deleteProduct(product.id),
        child: ListTile(
          title: Text('${product.title} - ${product.value}'),
          subtitle: Text(product.id),
          onTap: () => Navigator.pushNamed(context, 'product', arguments: product),
      ),

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
