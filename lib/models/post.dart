class Post {
  String id;
  String userId;
  String title;
  String body;
  List comments;
  DateTime createdAt;
  DateTime updatedAt;

  Post({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.comments,
    this.createdAt,
    this.updatedAt,
  });

  Post.fromMap(post) {
    this.id = post["_id"];
    this.userId = post["userId"];
    this.title = post["title"];
    this.body = post["body"];
    this.comments = post["comments"];
    this.createdAt = DateTime.parse(post["createdAt"]);
    this.updatedAt = DateTime.parse(post["updatedAt"]);
  }
}
