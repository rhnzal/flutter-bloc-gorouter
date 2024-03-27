// utk service sama seperti sebelumnya

import 'package:flutter_bloc_architecture/data/api_endpoints.dart';
import 'package:flutter_bloc_architecture/data/utils/http.dart' as http;

import '../models/response.dart';

class UserService {
  static Future<HTTPResponse> getUserListData() async {
    return http.get(userListWithDelayAPI(delay: 4));
  }
}