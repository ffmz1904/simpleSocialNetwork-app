import 'package:ssn/models/comment.dart';
import 'package:ssn/models/user.dart';

class Post {
  String id;
  String userId;
  User userData;
  String title;
  String body;
  List comments;
  List commentsData;
  DateTime createdAt;
  DateTime updatedAt;

  Post.fromMap(post) {
    this.id = post["_id"];
    this.userId = post["userId"];
    this.userData = User.fromMap(post["userData"]);
    this.title = post["title"];
    this.body = post["body"];
    this.comments = post["comments"];
    this.commentsData =
        post["comments"].length == 0 ? [] : post["commentsData"];
    this.createdAt = DateTime.parse(post["createdAt"]);
    this.updatedAt = DateTime.parse(post["updatedAt"]);
  }
}
