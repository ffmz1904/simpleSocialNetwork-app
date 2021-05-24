class User {
  String email;
  String name;
  String image;
  List friends;

  User({
    this.email,
    this.name,
    this.image,
    this.friends,
  });

  User.fromMap(user) {
    this.email = user["email"];
    this.name = user["name"];
    this.image = user["img"];
    this.friends = user["friends"];
  }
}
