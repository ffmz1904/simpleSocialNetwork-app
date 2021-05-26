import 'package:ssn/models/post.dart';
import 'package:ssn/models/user.dart';

class AppState {
  Map<String, dynamic> user;
  List<Post> posts;
  List<User> people;

  AppState({
    this.posts,
    this.user,
    this.people,
  });
}
