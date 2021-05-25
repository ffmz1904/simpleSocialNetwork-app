import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/comment.dart';
import 'package:ssn/models/post.dart';
import 'package:ssn/screens/comments_screen.dart';
import 'package:ssn/widgets/nav_drawer.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as PostScreenArgs;
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("SSN"),
      ),
      body: StoreConnector<AppState, Post>(
        converter: (store) =>
            store.state.posts.where((post) => post.id == args.id).first,
        builder: (context, post) {
          return Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("by " + post.userData["name"]),
                      Text(
                        '${post.updatedAt.day}.${post.updatedAt.month}.${post.updatedAt.year}',
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
                Text(
                  post.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  post.body,
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 2,
                                color:
                                    Theme.of(context).colorScheme.background))),
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, "/comments",
                          arguments: CommentsScreenArgs(
                              comments: List.from(post.commentsData
                                  .map((comment) => Comment.fromMap(comment))
                                  .toList()))),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.comments),
                          SizedBox(width: 10),
                          Text('${post.comments.length}'),
                        ],
                      ),
                    ))
              ]));
        },
      ),
    );
  }
}

class PostScreenArgs {
  final String id;
  PostScreenArgs({this.id});
}
