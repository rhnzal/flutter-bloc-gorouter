// utk service sama seperti sebelumnya

import 'package:flutter_bloc_architecture/src/data/api_endpoints.dart';
import 'package:flutter_bloc_architecture/src/data/utils/http.dart' as http;

import '../models/response.dart';

class UserService {
  static Future<HTTPResponse> getUserListData() async {
    return http.get(userListWithDelayAPI());
  }
}