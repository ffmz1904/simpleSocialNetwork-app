import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/comment.dart';
import 'package:ssn/widgets/add_comment_form.dart';
import 'package:ssn/widgets/comments_list_item.dart';
import 'package:ssn/widgets/nav_drawer.dart';

class CommentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as CommentsScreenArgs;
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("SSN"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Comments",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              StoreConnector<AppState, Map<String, dynamic>>(
                converter: (store) => store.state.user,
                builder: (context, user) {
                  if (user['isAuth']) {
                    return AddCommentForm(postId: args.postId);
                  }

                  return SizedBox();
                },
              ),
              StoreConnector<AppState, List<Comment>>(
                converter: (store) => store.state.posts
                    .where((post) => post.id == args.postId)
                    .first
                    .commentsData
                    .map((e) => Comment.fromMap(e))
                    .toList(),
                builder: (context, comments) {
                  if (comments.length == 0) {
                    return Center(child: Text('no comments'));
                  }

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                          itemCount: comments.length,
                          itemBuilder: (context, i) =>
                              CommentListItem(comment: comments[i])),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentsScreenArgs {
  String postId;
  CommentsScreenArgs({this.postId});
}
