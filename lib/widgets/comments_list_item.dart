import 'package:flutter/material.dart';
import 'package:ssn/models/comment.dart';

class CommentListItem extends StatelessWidget {
  final Comment comment;

  CommentListItem({this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Text(comment.userData.name),
            Text(comment.body),
          ],
        ),
      ),
    );
  }
}
