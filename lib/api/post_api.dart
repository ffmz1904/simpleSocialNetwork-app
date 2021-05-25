import 'package:ssn/api/api.dart';

class PostApi {
  static String apiBaseUri = 'api/post/';

  static Future getAll() async {
    Map response = await Api.get(endpoint: apiBaseUri).request();
    return response;
  }

  static Future createPost(title, body) async {
    Map response = await Api.post(
        endpoint: apiBaseUri, body: {'title': title, 'body': body}).request();
    return response;
  }
}
