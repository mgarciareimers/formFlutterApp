import 'dart:convert';

import 'package:formflutterapp/src/preferences/preferences.dart';
import 'package:http/http.dart' as http;

class UsersProvider {

  final String _firebaseToken = 'AIzaSyB8chrbuUhJ6Dh6baKpAXq-JMcl1AETq7Y';
  final _preferences = new Preferences();

  Future<Map<String, dynamic>> newUser(String email, String password) async {
    final authData = {
      'email' : email,
      'password' : password,
      'returnSecureToken' : true,
    };

    final response = await http.post('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${this._firebaseToken}', body: json.encode(authData));

    Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse.containsKey('idToken')) {
      this._preferences.token = decodedResponse['idToken'];
      return { 'ok' : true, 'token' : decodedResponse['idToken'] };
    } else {
      return { 'ok' : false, 'message' : decodedResponse['error']['message'] };
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email' : email,
      'password' : password,
      'returnSecureToken' : true,
    };

    final response = await http.post('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${this._firebaseToken}', body: json.encode(authData));

    Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse.containsKey('idToken')) {
      this._preferences.token = decodedResponse['idToken'];
      return { 'ok' : true, 'token' : decodedResponse['idToken'] };
    } else {
      return { 'ok' : false, 'message' : decodedResponse['error']['message'] };
    }
  }
}