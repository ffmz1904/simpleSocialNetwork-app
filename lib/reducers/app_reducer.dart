import 'package:ssn/app_state.dart';
import 'package:ssn/reducers/people_reducer.dart';
import 'package:ssn/reducers/post_reducer.dart';
import 'package:ssn/reducers/user_reducer.dart';

AppState appReducer(AppState state, action) => new AppState(
      user: userReducer(state.user, action),
      posts: postReducer(state.posts, action),
      people: peopleReducer(state.people, action),
    );
