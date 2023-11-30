part of 'my_account_bloc.dart';

@immutable
sealed class MyAccountState {}

final class MyAccountInitial extends MyAccountState {}

final class MyAccountLoading extends MyAccountState {}

final class MyAccountSuccess extends MyAccountState {
  final UserModel user;
  MyAccountSuccess({required this.user});
}

final class MyAccountFailure extends MyAccountState {}


final class RedirectToLogin extends MyAccountState {}