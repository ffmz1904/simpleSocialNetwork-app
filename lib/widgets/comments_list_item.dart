import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ssn/actions/post_actions.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/comment.dart';
import 'package:ssn/models/user.dart';

class CommentListItem extends StatelessWidget {
  final Comment comment;

  CommentListItem({this.comment});

  Future removeComment(context) {
    Store<AppState> store = StoreProvider.of(context);
    Function remove = removeCommentAction(comment.id, comment.postId);
    store.dispatch(remove(store));
  }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'http://10.0.2.2:4000/' + comment.userData.image,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, left: 5),
                      child: Text(
                        comment.userData.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  StoreConnector<AppState, User>(
                    converter: (store) => store.state.user['data'],
                    builder: (context, user) {
                      if (user.id == comment.userId) {
                        return Container(
                          width: 30,
                          height: 20,
                          child: IconButton(
                              icon: Icon(Icons.close,
                                  size: 18, color: Colors.redAccent),
                              onPressed: () => removeComment(context)),
                        );
                      }

                      return SizedBox();
                    },
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
