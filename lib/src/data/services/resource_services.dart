import 'package:flutter_bloc_architecture/src/data/api_endpoints.dart';
import 'package:flutter_bloc_architecture/src/data/models/response.dart';

import '../utils/http.dart' as http;

class ResourceService {
  static Future<HTTPResponse> getResourcesData() {
    return http.get(resourcesListAPI());
  }
}