import 'package:flutter/material.dart';

import 'package:formflutterapp/src/blocs/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar:  AppBar(
        title: Center(child: Text('Home Page')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Text(bloc.email),
            Divider(),
            Text(bloc.password),
          ],
      ),
    );
  }
}
