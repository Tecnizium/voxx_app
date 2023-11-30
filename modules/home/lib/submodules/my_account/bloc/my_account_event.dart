part of 'my_account_bloc.dart';

@immutable
sealed class MyAccountEvent {}

class SaveButtonPressed extends MyAccountEvent {
  final UserModel user;
  SaveButtonPressed({required this.user});
}

class DeleteButtonPressed extends MyAccountEvent {
  final String username;
  DeleteButtonPressed({required this.username});
}
