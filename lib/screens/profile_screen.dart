import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/post.dart';
import 'package:ssn/models/user.dart';
import 'package:ssn/widgets/nav_drawer.dart';
import 'package:ssn/widgets/posts_list.dart';
import 'package:ssn/widgets/user_data.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SSN"),
      ),
      drawer: NavDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, "/create_post"),
      ),
      body: StoreConnector<AppState, User>(
        converter: (store) => store.state.user['data'],
        builder: (context, user) {
          return Container(
            child: Column(
              children: [
                UserData(data: user),
                SizedBox(height: 10),
                Expanded(
                  child: StoreConnector<AppState, List<Post>>(
                    converter: (store) => store.state.posts
                        .where((post) => post.userId == user.id)
                        .toList(),
                    builder: (context, posts) {
                      return PostsList(posts: posts);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
