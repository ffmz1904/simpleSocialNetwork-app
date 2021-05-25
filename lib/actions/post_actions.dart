import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:ssn/api/post_api.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/post.dart';

class SetAllPosts {
  List<Post> posts;
  SetAllPosts({this.posts});
}

class CreatePost {
  Post post;
  CreatePost({this.post});
}

ThunkAction<AppState> getAllPosts() {
  return (Store<AppState> store) async {
    final response = await PostApi.getAll();
    List<Post> posts =
        List.from(response["posts"]).map((post) => Post.fromMap(post)).toList();
    store.dispatch(SetAllPosts(posts: posts));
  };
}

ThunkAction<AppState> createPostAction(title, body) {
  return (Store<AppState> store) async {
    final response = await PostApi.createPost(title, body);
    store.dispatch(CreatePost(post: Post.fromMap(response["post"])));
  };
}
