import 'package:redux/redux.dart';
import 'package:ssn/actions/people_actions.dart';
import 'package:ssn/models/user.dart';

Reducer<List<User>> peopleReducer = combineReducers([
  TypedReducer<List<User>, SetAllUsers>(setPeople),
]);

List<User> setPeople(List<User> people, SetAllUsers action) {
  return action.people;
}
