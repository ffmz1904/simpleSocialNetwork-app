import 'package:flutter/material.dart';
import 'package:ssn/models/comment.dart';
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
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Comments",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            args.comments.length == 0
                ? Text('no comments')
                : Expanded(
                    child: ListView.builder(
                        itemCount: args.comments.length,
                        itemBuilder: (context, i) =>
                            CommentListItem(comment: args.comments[i])),
                  ),
          ],
        ),
      ),
    );
  }
}

class CommentsScreenArgs {
  List<Comment> comments;

  CommentsScreenArgs({this.comments});
}
