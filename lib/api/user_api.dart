import 'package:ssn/api/api.dart';

class UserApi {
  static Future registration(name, email, password) async {
    Map response = await Api.post(endpoint: 'api/user/registration', body: {
      "email": email,
      "password": password,
      "name": name,
    }).request();

    return response;
  }

  static Future login(email, password) async {
    Map response = await Api.post(endpoint: 'api/user/login', body: {
      "email": email,
      "password": password,
    }).request();

    return response;
  }
}
