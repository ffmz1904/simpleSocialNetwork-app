import 'package:redux/redux.dart';
import 'package:ssn/actions/post_actions.dart';
import 'package:ssn/models/post.dart';

Reducer<List<Post>> postReducer = combineReducers([
  TypedReducer<List<Post>, SetAllPosts>(setPosts),
]);

List<Post> setPosts(List<Post> posts, SetAllPosts action) {
  return action.posts;
}
