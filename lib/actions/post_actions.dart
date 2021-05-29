import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:ssn/actions/error_action.dart';
import 'package:ssn/api/comment_api.dart';
import 'package:ssn/api/post_api.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/comment.dart';
import 'package:ssn/models/post.dart';

class SetAllPosts {
  List<Post> posts;
  SetAllPosts({this.posts});
}

class CreatePost {
  Post post;
  CreatePost({this.post});
}

class UpdatePost {
  Post post;
  UpdatePost({this.post});
}

class RemovePost {
  String id;
  RemovePost({this.id});
}

class CreateComment {
  Comment comment;
  CreateComment({this.comment});
}

class RemoveComment {
  String postId;
  String commentId;
  RemoveComment({this.postId, this.commentId});
}

ThunkAction<AppState> getAllPosts(cb) {
  return (Store<AppState> store) async {
    final response = await PostApi.getAll();

    if (response['success'] == null) {
      return store.dispatch(SetError(message: response['message']));
    }

    List<Post> posts =
        List.from(response["posts"]).map((post) => Post.fromMap(post)).toList();
    store.dispatch(SetAllPosts(posts: posts));
    cb();
  };
}

ThunkAction<AppState> createPostAction(title, body, cb) {
  return (Store<AppState> store) async {
    final response = await PostApi.createPost(title, body);

    if (response['success'] == null) {
      return store.dispatch(SetError(message: response['message']));
    }

    store.dispatch(CreatePost(post: Post.fromMap(response["post"])));
    cb();
  };
}

ThunkAction<AppState> updatePostAction(postId, title, body, cb) {
  return (Store<AppState> store) async {
    final response = await PostApi.updatePost(postId, title, body);

    if (response['success'] == null) {
      return store.dispatch(SetError(message: response['message']));
    }

    store.dispatch(UpdatePost(post: Post.fromMap(response["post"])));
    cb();
  };
}

ThunkAction<AppState> removePostAction(postId) {
  return (Store<AppState> store) async {
    final response = await PostApi.removePost(postId);

    if (response['success'] == null) {
      return store.dispatch(SetError(message: response['message']));
    }

    store.dispatch(RemovePost(id: postId));
  };
}

ThunkAction<AppState> createCommentAction(postId, text) {
  return (Store<AppState> store) async {
    final response = await CommentApi.createComment(postId, text);

    if (response['success'] == null) {
      return store.dispatch(SetError(message: response['message']));
    }

    store
        .dispatch(CreateComment(comment: Comment.fromMap(response["comment"])));
  };
}

ThunkAction<AppState> removeCommentAction(commentId, postId) {
  return (Store<AppState> store) async {
    final response = await CommentApi.removeComment(commentId);

    if (response['success'] == null) {
      return store.dispatch(SetError(message: response['message']));
    }

    store.dispatch(RemoveComment(postId: postId, commentId: commentId));
  };
}
