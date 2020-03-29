import 'package:flutter/material.dart';

import 'package:formflutterapp/src/commons/utils.dart' as utils;
import 'package:formflutterapp/src/models/product_model.dart';
import 'package:formflutterapp/src/providers/products_provider.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  ProductModel product = new ProductModel();
  final productProvider = new ProductsProvider();

  @override
  Widget build(BuildContext context) {
    this._loadData(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.photo_size_select_actual), onPressed: (){}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: (){}),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: this.formKey,
            child: Column(
              children: <Widget>[
                this._createName(),
                this._createPrice(),
                this._createAvailable(),
                SizedBox(height: 20),
                this._createSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method that loads the data.
  void _loadData(BuildContext context) {
    final ProductModel productData = ModalRoute.of(context).settings.arguments;

    if (productData != null) {
      this.product = productData;
    }
  }
  
  // Method that creates the name form input.
  Widget _createName() {
    return TextFormField(
      initialValue: this.product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product',
      ),
      validator: (value) => value.length >= 3 ? null : 'Product name is invalid (min 3 characters)',
      onSaved: (value) => this.product.title = value,
    );
  }
  
  // Method that creates the price form input.
  Widget _createPrice() {
    return TextFormField(
      initialValue: this.product.value.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Price',
      ),
      validator: (value) => utils.isNumber(value) ? null : 'Price has to be a number',
      onSaved: (value) => this.product.value = double.parse(value),
    );
  }

  // Method that creates the availability switch;
  Widget _createAvailable() {
    return SwitchListTile(
      value: this.product.available,
      title: Text('Available'),
      onChanged: (bool value) => setState(() => this.product.available = value),
      activeColor: Colors.deepPurple,
    );
  }

  // Method that creates the submit button.
  Widget _createSubmitButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
      ),
      label: Text('Submit'),
      icon: Icon(Icons.save),
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: () {
        this._submit();
      },
    );
  }

  // Method that is called when the user clicks the submit button.
  void _submit() {
    if (!this.formKey.currentState.validate()) {
      return;
    }

    this.formKey.currentState.save(); // Fires the onSaved() event of the Widgets.

    this.product.id == null ? this.productProvider.createProduct(this.product) : this.productProvider.editProduct(this.product);
  }
}