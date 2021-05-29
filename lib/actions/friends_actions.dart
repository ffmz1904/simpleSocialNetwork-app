import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:ssn/actions/error_action.dart';
import 'package:ssn/api/user_api.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/user.dart';

class SetAllFriends {
  List<User> friends;
  SetAllFriends({this.friends});
}

ThunkAction<AppState> getUserFriendsAction(userId, friendsType, cb) {
  return (Store<AppState> store) async {
    final response = await UserApi.getFriends(userId, friendsType);

    if (response['success'] == null) {
      return store.dispatch(SetError(message: response['message']));
    }

    store.dispatch(SetAllFriends(
        friends: List.from(response["friendsData"]
            .map((user) => User.fromMap(user))
            .toList())));
    cb();
  };
}
