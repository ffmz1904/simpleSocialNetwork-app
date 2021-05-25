import 'package:ssn/models/user.dart';

class Comment {
  String id;
  String userId;
  String postId;
  String body;
  DateTime createdAt;
  DateTime updatedAt;
  User userData;

  Comment(
      {this.id,
      this.userId,
      this.postId,
      this.body,
      this.createdAt,
      this.updatedAt,
      this.userData});

  Comment.fromMap(comment) {
    this.id = comment["_id"];
    this.userId = comment["userId"];
    this.postId = comment["postId"];
    this.body = comment["body"];
    this.createdAt = DateTime.parse(comment["createdAt"]);
    this.updatedAt = DateTime.parse(comment["updatedAt"]);
    this.userData = User.fromMap(comment["userData"]);
  }
}
