import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:formflutterapp/src/commons/utils.dart' as utils;
import 'package:formflutterapp/src/models/product_model.dart';
import 'package:formflutterapp/src/providers/products_provider.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductModel product = new ProductModel();
  final productProvider = new ProductsProvider();

  bool _isSaving = false;
  File picture = null;

  @override
  Widget build(BuildContext context) {
    this._loadData(context);

    return Scaffold(
      key: this.scaffoldKey,
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.photo_size_select_actual), onPressed: () => this._processImage(ImageSource.gallery)),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () => this._processImage(ImageSource.camera)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: this.formKey,
            child: Column(
              children: <Widget>[
                this._createPicture(),
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

  // Method that shows the picture.
  Widget _createPicture() {
    print('Picture: ${picture?.path}');
    if (product.pictureUrl != null) {
      return FadeInImage(
        image: NetworkImage(product.pictureUrl),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300,
        fit: BoxFit.cover
      );
    } else {
      return Image(
        image: AssetImage(picture?.path ?? 'assets/no-image.png'),
        height: 300,
        fit: BoxFit.cover,
      );
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
      disabledTextColor: Colors.white,
      onPressed: this._isSaving ? null : () => this._submit(),
    );
  }

  // Method that is called when the user clicks the submit button.
  void _submit() async {
    if (!this.formKey.currentState.validate()) {
      return;
    }

    this.formKey.currentState.save(); // Fires the onSaved() event of the Widgets.

    this.setState(() => _isSaving = true);
    
    if (picture != null) {
      this.product.pictureUrl = await this.productProvider.uploadImage(picture);
    }

    this.product.id == null ? this.productProvider.createProduct(this.product) : this.productProvider.editProduct(this.product);

    this._showSnackbar('Product has been saved!');
    
    Navigator.pop(context);
  }

  // Method that shows a snackbar.
  void _showSnackbar(String message) {
    this.scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message), duration: Duration(milliseconds: 1500)));
  }

  // Method that is called when the user clicks the picture/camera button.
  _processImage(ImageSource source) async {
    try {
      picture = await ImagePicker.pickImage(source: source);

      if (picture != null) {
        this.product.pictureUrl = null;
      }

      this.setState(() {});
    } catch(e) {
      print('Exception $e}');
    }
  }
}