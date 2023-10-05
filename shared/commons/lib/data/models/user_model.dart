import 'dart:convert';

class UserModel {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  int? role;

  UserModel({
    this.id,
    required this.username,
    this.firstName,
    this.lastName,
    required this.email,
    required this.role,
    this.password,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      firstName: map['userDetails']?['firstName'],
      lastName: map['userDetails']?['lastName'],
      email: map['userAuth']?['email'],
      password: map['userAuth']?['password'],
      role: map['userAuth']?['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'userAuth': {
        'email': email,
        'password': password,
        'role': role,
      },
      'userDetails': {
        'firstName': firstName,
        'lastName': lastName,
      }
    };
  }
}
