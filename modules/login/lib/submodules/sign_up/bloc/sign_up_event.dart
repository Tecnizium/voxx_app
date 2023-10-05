part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}


class SignUpButtonPressed extends SignUpEvent {
  final String username;
  final String email;
  final String password;

  SignUpButtonPressed({required this.username, required this.email, required this.password});
}