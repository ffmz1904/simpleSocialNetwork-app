class User {
  String id;
  String email;
  String name;
  String image;
  List friends;

  User({
    this.id,
    this.email,
    this.name,
    this.image,
    this.friends,
  });

  User.fromMap(user) {
    this.id = user["_id"];
    this.email = user["email"];
    this.name = user["name"];
    this.image = user["img"];
    this.friends = user["friends"];
  }
}
