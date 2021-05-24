import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ssn/actions/post_actions.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/post.dart';
import 'package:ssn/widgets/nav_drawer.dart';
import 'package:ssn/widgets/posts_list.dart';

class HomeScreen extends StatelessWidget {
  final Function getPosts = getAllPosts();

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of(context);
    store.dispatch(getPosts(store));

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("SSN"),
      ),
      body: StoreConnector<AppState, List<Post>>(
          converter: (store) => store.state.posts,
          builder: (context, posts) {
            return PostsList(posts: posts);
          }),
    );
  }
}
