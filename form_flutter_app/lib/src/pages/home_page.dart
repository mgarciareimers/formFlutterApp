import 'package:flutter/material.dart';

import 'package:formflutterapp/src/blocs/provider.dart';
import 'package:formflutterapp/src/models/product_model.dart';
import 'package:formflutterapp/src/preferences/preferences.dart';

class HomePage extends StatelessWidget {
  final preferences = new Preferences();

  @override
  Widget build(BuildContext context) {

    final productsBloc = Provider.productsBloc(context);
    productsBloc.getProducts();

    return Scaffold(
      appBar:  AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () => this._logout(context)),
        ],
      ),
      body: this._createProductList(productsBloc),
      floatingActionButton: this._createButton(context),
    );
  }

  // Method that logs the user out.
  _logout(BuildContext context) {
    this.preferences.token = null;
    Navigator.pushReplacementNamed(context, 'login');
  }

  // Method that creates the product list.
  Widget _createProductList(ProductsBloc productsBloc) {
    return StreamBuilder(
      stream: productsBloc.productsStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => this._createListItem(context, productsBloc, products[index]),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  // Method that creates the list item.
  Widget _createListItem(BuildContext context, ProductsBloc productsBloc, ProductModel product) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) => productsBloc.deleteProduct(product.id),
        child: Card(
          child: Column(
            children: <Widget>[
              GestureDetector(
               child: (product.pictureUrl == null ?
                  Image(image: AssetImage('assets/no-image.png')) :
                  FadeInImage(image: NetworkImage(product.pictureUrl), placeholder: AssetImage('assets/jar-loading.gif'), height: 300, width: double.infinity, fit: BoxFit.cover)
                ),
                onTap: () => Navigator.pushNamed(context, 'product', arguments: product),
              ),
              ListTile(
                title: Text('${product.title} - ${product.value}'),
                subtitle: Text(product.id),
                onTap: () => Navigator.pushNamed(context, 'product', arguments: product),
              ),
            ],
          ),
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