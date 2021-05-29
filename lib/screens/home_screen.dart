import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ssn/actions/post_actions.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/post.dart';
import 'package:ssn/widgets/error_window.dart';
import 'package:ssn/widgets/nav_drawer.dart';
import 'package:ssn/widgets/posts_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;

  void setLoading() => setState(() => loading = !loading);

  @override
  Widget build(BuildContext context) {
    if (loading) {
      Store<AppState> store = StoreProvider.of(context);
      Function getPosts = getAllPosts(setLoading);
      store.dispatch(getPosts(store));
    }

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("SSN"),
      ),
      body: StoreConnector<AppState, String>(
        converter: (store) => store.state.error,
        builder: (context, error) {
          return Stack(
            children: [
              StoreConnector<AppState, List<Post>>(
                  converter: (store) => store.state.posts,
                  builder: (context, posts) {
                    if (loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return PostsList(posts: posts);
                  }),
              error != null ? ErrorWindow() : SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
