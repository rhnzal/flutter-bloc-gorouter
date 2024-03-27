import 'package:flutter_bloc_architecture/src/data/api_endpoints.dart';
import 'package:flutter_bloc_architecture/src/data/models/response.dart';
import '../utils/http.dart' as http;

class AuthServices {
  static Future<HTTPResponse> login({required String email, required String password}) async {
    return http.post(
      loginAPI(),
      body: {
        'email': email,
        'password': password
      }
    );
  }

}