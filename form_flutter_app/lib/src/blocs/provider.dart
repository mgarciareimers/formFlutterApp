import 'package:flutter/material.dart';
import 'package:formflutterapp/src/blocs/login_bloc.dart';
export 'package:formflutterapp/src/blocs/login_bloc.dart';

class Provider extends InheritedWidget{

  static Provider _instance;

  factory Provider({ Key key, Widget child }) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }

    return _instance;
  }

  Provider._internal({ Key key, Widget child }) : super(key: key, child: child);

  //Provider({ Key key, Widget child }) : super(key: key, child: child);

  final LoginBloc loginBloc = LoginBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of (BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc);
  }
}