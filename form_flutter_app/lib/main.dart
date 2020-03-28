import 'package:flutter/material.dart';

import 'package:formflutterapp/src/pages/login_page.dart';
import 'package:formflutterapp/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'home' : (BuildContext context) => HomePage(),
      },
    );
  }
}
