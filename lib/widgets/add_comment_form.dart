import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ssn/actions/post_actions.dart';
import 'package:ssn/app_state.dart';

class AddCommentForm extends StatefulWidget {
  final String postId;

  AddCommentForm({this.postId});

  @override
  _AddCommentFormState createState() => _AddCommentFormState();
}

class _AddCommentFormState extends State<AddCommentForm> {
  TextEditingController _text = TextEditingController();

  Future addComment(context) async {
    Store<AppState> store = StoreProvider.of(context);
    Function createComment = createCommentAction(widget.postId, _text.text);
    store.dispatch(createComment(store));
    _text.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          TextField(
            controller: _text,
            maxLines: 3,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(8, 8, 35, 8),
                hintText: 'Comment text ...',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 5.0),
                )),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              size: 18,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () => addComment(context),
          )
        ],
      ),
    );
  }
}
