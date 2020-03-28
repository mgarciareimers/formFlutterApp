import 'dart:async';

import 'package:formflutterapp/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Get values from Stream.
  Stream<String> get emailStream => this._emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => this._passwordController.stream.transform(validatePassword);

  Stream<bool> get formIsValidStream => CombineLatestStream.combine2(this.emailStream, this.passwordStream, (email, password) => true);

  // Set values to Stream.
  Function(String) get changeEmail => this._emailController.sink.add;
  Function(String) get changePassword => this._passwordController.sink.add;

  // Get last values of the streams.
  String get email => this._emailController.value;
  String get password => this._passwordController.value;

  // Close Stream Controllers.
  dispose() {
    this._emailController?.close();
    this._passwordController?.close();
  }
}