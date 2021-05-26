import 'package:ssn/api/api.dart';

class CommentApi {
  static String apiBaseUri = 'api/comment/';

  static Future createComment(postId, body) async {
    Map response = await Api.post(
        endpoint: apiBaseUri, body: {'postId': postId, 'body': body}).request();
    return response;
  }
}
