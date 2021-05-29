import 'package:redux/redux.dart';
import 'package:ssn/actions/post_actions.dart';
import 'package:ssn/models/post.dart';

Reducer<List<Post>> postReducer = combineReducers([
  TypedReducer<List<Post>, SetAllPosts>(setPosts),
  TypedReducer<List<Post>, CreatePost>(createPost),
  TypedReducer<List<Post>, UpdatePost>(updatePost),
  TypedReducer<List<Post>, RemovePost>(removePost),
  TypedReducer<List<Post>, CreateComment>(createComment),
  TypedReducer<List<Post>, RemoveComment>(removeComment),
]);

List<Post> setPosts(List<Post> posts, SetAllPosts action) {
  return action.posts;
}

List<Post> createPost(List<Post> posts, CreatePost action) {
  List<Post> postsList = [action.post] + posts;
  return postsList;
}

List<Post> updatePost(List<Post> posts, UpdatePost action) {
  List<Post> postsList = posts
      .map((post) => post.id != action.post.id ? post : action.post)
      .toList();
  return postsList;
}

List<Post> removePost(List<Post> posts, RemovePost action) {
  List<Post> postsList = posts.where((post) => post.id != action.id).toList();
  return postsList;
}

List<Post> createComment(List<Post> posts, CreateComment action) {
  List<Post> postsList = posts.map((post) {
    if (post.id != action.comment.postId) {
      return post;
    }
    post.comments.add(action.comment.id);
    post.commentsData = [action.comment] + post.commentsData;
    return post;
  }).toList();
  return postsList;
}

List<Post> removeComment(List<Post> posts, RemoveComment action) {
  List<Post> postsList = posts.map((post) {
    if (post.id == action.postId) {
      post.comments =
          post.comments.where((id) => id != action.commentId).toList();
      post.commentsData = post.commentsData
          .where((comment) => comment.id != action.commentId)
          .toList();
      return post;
    }

    return post;
  }).toList();
  return postsList;
}
