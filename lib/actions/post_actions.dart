import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:ssn/api/post_api.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/post.dart';

class SetAllPosts {
  List<Post> posts;
  SetAllPosts({this.posts});
}

ThunkAction<AppState> getAllPosts() {
  return (Store<AppState> store) async {
    final response = await PostApi.getAll();
    store.dispatch(SetAllPosts(posts: response["posts"]));
  };
}
