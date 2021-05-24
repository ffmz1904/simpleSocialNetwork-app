import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ssn/api/user_api.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/post.dart';
import 'package:ssn/models/user.dart';
import 'package:ssn/widgets/nav_drawer.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool loading = true;
  User author;

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
          UserApi.getUserDataById(post.userId)
              .then((value) => this.author = User.fromMap(value['user']))
              .whenComplete(() => setState(() => loading = false));

          if (loading) {
            return Text('loading');
          }

          return Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("by " + author.name),
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
            ]),
          );
        },
      ),
    );
  }
}

class PostScreenArgs {
  final String id;
  PostScreenArgs({this.id});
}
