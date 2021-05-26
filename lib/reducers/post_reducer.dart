import 'package:redux/redux.dart';
import 'package:ssn/actions/post_actions.dart';
import 'package:ssn/models/post.dart';

Reducer<List<Post>> postReducer = combineReducers([
  TypedReducer<List<Post>, SetAllPosts>(setPosts),
  TypedReducer<List<Post>, CreatePost>(createPost),
  TypedReducer<List<Post>, CreateComment>(createComment),
]);

List<Post> setPosts(List<Post> posts, SetAllPosts action) {
  return action.posts;
}

List<Post> createPost(List<Post> posts, CreatePost action) {
  List<Post> postsList = [action.post] + posts;
  return postsList;
}

List<Post> createComment(List<Post> posts, CreateComment action) {
  List<Post> postsList = posts.map((post) {
    if (post.id != action.comment['postId']) {
      return post;
    }
    dynamic comment = action.comment;

    post.comments.add(action.comment['_id']);
    post.commentsData = [comment] + post.commentsData;
    return post;
  }).toList();
  return postsList;
}
