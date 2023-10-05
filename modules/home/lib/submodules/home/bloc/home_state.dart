part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class UserCacheLoadedState extends HomeState {
  final UserModel user;
  UserCacheLoadedState({
    required this.user,
    });
}

final class CampaignCacheLoadedState extends HomeState {
  final String campaignId;
  CampaignCacheLoadedState({
    required this.campaignId,
    });
}

final class PollsLoadedState extends HomeState {
  final List<PollModel> polls;
  PollsLoadedState({
    required this.polls,
    });
}
