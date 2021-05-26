import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssn/models/post.dart';
import 'package:ssn/screens/comments_screen.dart';
import 'package:ssn/screens/post_screen.dart';

class PostListItem extends StatelessWidget {
  final Post post;

  PostListItem({this.post});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/post",
          arguments: PostScreenArgs(id: post.id)),
      child: Card(
        margin: EdgeInsets.only(bottom: 20),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                post.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                post.body,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            FontAwesomeIcons.comments,
                            size: 16,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () => Navigator.pushNamed(
                              context, "/comments",
                              arguments: CommentsScreenArgs(postId: post.id))),
                      Text(
                        post.comments.length.toString(),
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${post.updatedAt.day}.${post.updatedAt.month}.${post.updatedAt.year}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
