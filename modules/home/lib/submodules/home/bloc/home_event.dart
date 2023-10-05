part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LogoutEvent extends HomeEvent {}

class GetUserCacheEvent extends HomeEvent {
  GetUserCacheEvent();
}

class GetCampaignCacheEvent extends HomeEvent {
  GetCampaignCacheEvent();
}

class UpdateCampaignButtonPressed extends HomeEvent {
  final String campaignId;
  UpdateCampaignButtonPressed({required this.campaignId});
}

class GetPollsEvent extends HomeEvent {
  final String campaignId;
  GetPollsEvent({required this.campaignId});
}