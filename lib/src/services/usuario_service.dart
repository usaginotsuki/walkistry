import 'dart:convert';

import 'package:walkistry_flutter/src/models/login_model.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class UsuarioService {
  final String _firebaseKey = 'AIzaSyB9kAcjuwfnlUR9y6m4DT1ulyEITegvfCo';
  UsuarioService();
  Future<Map<String, dynamic>> login(UserLogin user) async {
    try {
      final authData = {
        'email': user.email,
        'password': user.password,
        'returnSecureToken': true
      };
      final queryParams = {'key': _firebaseKey};
      var uri = Uri.https("www.googleapis.com",
          "/identitytoolkit/v3/relyingparty/verifyPassword", queryParams);

      var response = await http.post(uri, body: json.encode(authData));

      if (response.body.isEmpty) return <String, dynamic>{};

      Map<String, dynamic> decodedResponse = json.decode(response.body);

      return decodedResponse;
    } catch (e) {
      developer.log(e.toString(), name: "UsuarioService");
      return <String, dynamic>{};
    }
  }
}
