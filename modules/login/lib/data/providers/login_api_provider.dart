import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';

class LoginApiProvider {
  final Dio dio = Dio();

  Future<Response> signIn(String username, String password) async {
    try {
      return await dio.post('https://guardian-gate.kindrock-da55ab0b.eastus.azurecontainerapps.io/User/signin',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization':
                  'Basic ${base64Encode(utf8.encode("tWgR44A4Bs:BpD63GcT8c"))}'
            },
          ),
          data: {'username': username, 'password': base64Encode(utf8.encode(password))});
    } on DioException catch (e) {
      return e.response as Response;
    }
  }

  Future<Response> signUp(String username, String email, String password) async {
    UserModel user = UserModel(username: username, email: email, password: base64Encode(utf8.encode(password)), role: 1);
    try {
      return await dio.post('https://guardian-gate.kindrock-da55ab0b.eastus.azurecontainerapps.io/User/signup',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization':
                  'Basic ${base64Encode(utf8.encode("tWgR44A4Bs:BpD63GcT8c"))}'
            },
          ),
          data: user.toJson());
    } on DioException catch (e) {
      return e.response as Response;
    }
  }

  Future<Response> getUser(String jwtToken) async {
    return await dio.get('https://guardian-gate.kindrock-da55ab0b.eastus.azurecontainerapps.io/User/getuser',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $jwtToken'
          },
        ));
}
}