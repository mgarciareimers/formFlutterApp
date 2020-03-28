import 'package:flutter/material.dart';

import 'package:formflutterapp/src/pages/login_page.dart';
import 'package:formflutterapp/src/pages/home_page.dart';
import 'package:formflutterapp/src/blocs/provider.dart';
import 'package:formflutterapp/src/pages/product_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage(),
          'product' : (BuildContext context) => ProductPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
