import 'package:ssn/api/api.dart';

class PostApi {
  static String apiBaseUri = 'api/post/';

  static Future getAll() async {
    Map response = await Api.get(endpoint: apiBaseUri).request();
    return response;
  }
}
