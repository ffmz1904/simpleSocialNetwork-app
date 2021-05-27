class User {
  String id;
  String email;
  String name;
  String image;
  List follow;
  List subscribers;

  User({
    this.id,
    this.email,
    this.name,
    this.image,
    this.follow,
    this.subscribers,
  });

  User.fromMap(user) {
    this.id = user["_id"];
    this.email = user["email"];
    this.name = user["name"];
    this.image = user["img"];
    this.follow = user["follow"];
    this.subscribers = user["subscribers"];
  }
}
