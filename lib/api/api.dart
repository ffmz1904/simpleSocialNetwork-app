import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:ssn/helpers/token_handler.dart';

enum RequestMethod {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
}

class Api {
  final String serverUri = "http://10.0.2.2:4000/";
  String endpoint;
  Map<String, dynamic> body = {};
  FormData formData;
  RequestMethod method = RequestMethod.GET;

  Api.get({this.endpoint});

  Api.post({this.endpoint, this.body, this.formData})
      : this.method = RequestMethod.POST;

  Api.put({this.endpoint, this.body, this.formData})
      : this.method = RequestMethod.PUT;

  Api.patch({this.endpoint, this.body, this.formData})
      : this.method = RequestMethod.PATCH;

  Api.delete({this.endpoint}) : this.method = RequestMethod.DELETE;

  Future request() async {
    var uri = Uri.parse(this.serverUri + this.endpoint);
    var response;
    String token = await TokenHandler.getToken();

    switch (method) {
      case RequestMethod.GET:
        response =
            await http.get(uri, headers: {'Authorization': 'Bearer $token'});
        break;
      case RequestMethod.POST:
        response = await http.post(uri,
            body: this.body, headers: {'Authorization': 'Bearer $token'});
        break;
      case RequestMethod.PUT:
        response = await http.put(uri,
            body: this.body, headers: {'Authorization': 'Bearer $token'});
        break;
      case RequestMethod.PATCH:
        response = await http.patch(uri,
            body: this.body, headers: {'Authorization': 'Bearer $token'});
        break;
      case RequestMethod.DELETE:
        response =
            await http.delete(uri, headers: {'Authorization': 'Bearer $token'});
        break;
    }

    Map<String, dynamic> responseMap = jsonDecode(response.body);
    return responseMap;
  }

  Future formDataRequest() async {
    String uri = this.serverUri + this.endpoint;
    String token = await TokenHandler.getToken();

    var response;
    var dio = Dio();
    Options options = Options(headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    });

    switch (method) {
      case RequestMethod.POST:
        response = await dio.post(uri, data: this.formData, options: options);
        break;
      case RequestMethod.PUT:
        response = await dio.put(uri, data: this.formData, options: options);
        break;
      case RequestMethod.PATCH:
        response = await dio.patch(uri, data: this.formData, options: options);
        break;
    }

    Map<String, dynamic> responseMap = jsonDecode(response.toString());

    return responseMap;
  }
}
