import 'package:ssn/models/post.dart';

class AppState {
  Map<String, dynamic> user;
  List<Post> posts;

  AppState({
    this.posts,
    this.user,
  });
}
