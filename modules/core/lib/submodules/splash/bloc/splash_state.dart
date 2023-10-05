part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashLoading extends SplashState {}

final class RedirectLogin extends SplashState {}

final class RedirectHome extends SplashState {
  final UserModel user;
  RedirectHome({
    required this.user,});
}
