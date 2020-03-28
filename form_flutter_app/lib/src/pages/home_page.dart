import 'package:flutter/material.dart';

import 'package:formflutterapp/src/blocs/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar:  AppBar(
        title: Text('Home Page'),
      ),
      body: Container(),
      floatingActionButton: this._createButton(context),
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
