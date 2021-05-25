import 'package:flutter/material.dart';
import 'package:ssn/models/post.dart';
import 'package:ssn/widgets/post_list_item.dart';

class PostsList extends StatelessWidget {
  final List<Post> posts;

  PostsList({this.posts});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, i) => PostListItem(post: posts[i]),
      ),
    );
  }
}
