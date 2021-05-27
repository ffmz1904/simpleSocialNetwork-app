import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ssn/actions/user_actions.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/user.dart';

class FriendButton extends StatefulWidget {
  final User user;
  final String friendId;

  FriendButton({this.user, this.friendId});

  @override
  _FriendButtonState createState() => _FriendButtonState();
}

class _FriendButtonState extends State<FriendButton> {
  bool isSubscribe;

  @override
  void initState() {
    isSubscribe = widget.user.follow.contains(widget.friendId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of(context);

    return Container(
      child: isSubscribe ? _unsubscribeBtn(store) : _subscribeBtn(store),
    );
  }

  Widget _subscribeBtn(store) {
    return ElevatedButton(
      child: Text('Subscribe'),
      onPressed: () {
        Function subscribe = subscribeAction(widget.friendId);
        store.dispatch(subscribe(store));
        setState(() => isSubscribe = !isSubscribe);
      },
    );
  }

  Widget _unsubscribeBtn(store) {
    return ElevatedButton(
      child: Text('Unsubscribe'),
      style: ElevatedButton.styleFrom(primary: Colors.redAccent),
      onPressed: () {
        Function unsubscribe = unsubscribeAction(widget.friendId);
        store.dispatch(unsubscribe(store));
        setState(() => isSubscribe = !isSubscribe);
      },
    );
  }
}
