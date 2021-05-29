import 'package:redux/redux.dart';
import 'package:ssn/actions/error_action.dart';

Reducer<String> errorReducer = combineReducers([
  TypedReducer<String, SetError>(setError),
  TypedReducer<String, RemoveError>(removeError),
]);

String setError(String error, SetError action) => action.message;
String removeError(String error, RemoveError action) => null;
