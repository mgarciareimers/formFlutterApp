import 'package:flutter/material.dart';

import 'package:formflutterapp/src/commons/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 20),
                this._createSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createName() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product',
      ),
      validator: (value) => value.length >= 3 ? null : 'Product name is invalid (min 3 characters)'
    );
  }

  Widget _createPrice() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Price',
      ),
      validator: (value) => utils.isNumber(value) ? null : 'Price has to be a number'
    );
  }

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

  void _submit() {
    if (!this.formKey.currentState.validate()) {
      return;
    }

    print('Submitting...');
  }
}