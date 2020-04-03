import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instance = new Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();

  SharedPreferences _sharedPreferences;

  initPreferences() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
  }

  // Token.
  get token { return this._sharedPreferences.getString('token') ?? ''; }
  set token (String value) { this._sharedPreferences.setString('token', value); }
}