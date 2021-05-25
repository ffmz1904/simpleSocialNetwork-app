import 'package:flutter/material.dart';
import 'package:ssn/models/comment.dart';

class CommentListItem extends StatelessWidget {
  final Comment comment;

  CommentListItem({this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'http://10.0.2.2:4000/' + comment.userData.image,
                      ),
                    ),
                  ),
                  Text(
                    comment.userData.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 50),
                child: Text(
                  comment.body,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          )),
    );
  }
}
