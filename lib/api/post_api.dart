import 'package:ssn/api/api.dart';
import 'package:ssn/models/post.dart';

class PostApi {
  static Future getAll() async {
    Map response = await Api.get(endpoint: 'api/post').request();

    if (!response["success"]) {
      // todo error
    }

    List posts =
        List.from(response["posts"]).map((post) => Post.fromMap(post)).toList();

    return {"success": true, "posts": posts};
  }
}
