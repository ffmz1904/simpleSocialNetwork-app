import 'package:redux/redux.dart';
import 'package:ssn/actions/people_actions.dart';
import 'package:ssn/actions/user_actions.dart';
import 'package:ssn/models/user.dart';

Reducer<List<User>> peopleReducer = combineReducers([
  TypedReducer<List<User>, SetAllUsers>(setPeople),
  TypedReducer<List<User>, UpdateUserFriends>(updateFriendsList),
]);

List<User> setPeople(List<User> people, SetAllUsers action) {
  List<User> peopleList = action.people;
  return peopleList;
}

List<User> updateFriendsList(
  List<User> people,
  UpdateUserFriends action,
) {
  List<User> peopleList = people
      .map((user) => user.id == action.friend.id ? action.friend : user)
      .toList();
  return peopleList;
}
