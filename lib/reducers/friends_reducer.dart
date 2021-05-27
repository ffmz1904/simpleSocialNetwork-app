import 'package:redux/redux.dart';
import 'package:ssn/actions/friends_actions.dart';
import 'package:ssn/models/user.dart';

Reducer<List<User>> friendsReducer = combineReducers([
  TypedReducer<List<User>, SetAllFriends>(setFriends),
]);

List<User> setFriends(List<User> people, SetAllFriends action) {
  return action.friends;
}
