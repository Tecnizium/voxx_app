part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInSuccess extends SignInState {
  final UserModel user;
  SignInSuccess({
    required this.user,});
}

final class SignInError extends SignInState {
  final String message;
  SignInError({
    required this.message,});
}