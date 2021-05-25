class Post {
  String id;
  String userId;
  Map userData;
  String title;
  String body;
  List comments;
  List commentsData;
  DateTime createdAt;
  DateTime updatedAt;

  Post.fromMap(post) {
    this.id = post["_id"];
    this.userId = post["userId"];
    this.userData = post["userData"];
    this.title = post["title"];
    this.body = post["body"];
    this.comments = post["comments"];
    this.commentsData = post["commentsData"];
    this.createdAt = DateTime.parse(post["createdAt"]);
    this.updatedAt = DateTime.parse(post["updatedAt"]);
  }
}
