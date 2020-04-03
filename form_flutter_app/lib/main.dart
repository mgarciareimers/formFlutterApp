import 'package:flutter/material.dart';

import 'package:formflutterapp/src/pages/login_page.dart';
import 'package:formflutterapp/src/pages/home_page.dart';
import 'package:formflutterapp/src/blocs/provider.dart';
import 'package:formflutterapp/src/pages/product_page.dart';
import 'package:formflutterapp/src/pages/signup_page.dart';
import 'package:formflutterapp/src/preferences/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // TODO - Delete in case preferences alone works fine.
  final preferences = new Preferences();
  await preferences.initPreferences();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preferences = new Preferences();

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: preferences.token == null || preferences.token == '' ? 'login' : 'home',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'signup' : (BuildContext context) => SignUpPage(),
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
