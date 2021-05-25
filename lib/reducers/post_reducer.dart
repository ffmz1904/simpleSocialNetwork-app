import 'package:redux/redux.dart';
import 'package:ssn/actions/post_actions.dart';
import 'package:ssn/models/post.dart';

Reducer<List<Post>> postReducer = combineReducers([
  TypedReducer<List<Post>, SetAllPosts>(setPosts),
  TypedReducer<List<Post>, CreatePost>(createPost),
]);

List<Post> setPosts(List<Post> posts, SetAllPosts action) {
  return action.posts;
}

List<Post> createPost(List<Post> posts, CreatePost action) {
  List<Post> newPostsList = [action.post] + posts;
  return newPostsList;
}
