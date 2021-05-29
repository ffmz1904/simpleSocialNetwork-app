import 'package:ssn/models/post.dart';
import 'package:ssn/models/user.dart';

class AppState {
  Map<String, dynamic> user;
  List<Post> posts;
  List<User> people;
  List<User> friends;
  String error;

  AppState({
    this.posts,
    this.user,
    this.people,
    this.friends,
    this.error,
  });
}
