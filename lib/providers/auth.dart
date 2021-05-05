import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// Exception
import 'package:shop_app/models/http_exception.dart'; // HttpException

class Auth with ChangeNotifier {
  final apiKey = 'AIzaSyAv4Wl3chqcBmRdqOCE1L91QH14ts8ZT1k';

  String _token;
  DateTime _expiryDate;
  String _userId;

  // auth getter
  bool get isAuth {
    return token != null;
  }

  // token getter
  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  // Authenticate
  Future<void> _authenticate(String email, password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$apiKey');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);

      // to thorw error in case Firebase send you an error back in status code 200
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      // To set token / id / expiary date
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Register
  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  // login
  Future<void> signin(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}