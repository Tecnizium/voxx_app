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

class GetAnswersCacheEvent extends HomeEvent {
  GetAnswersCacheEvent();
}

class UpdateCampaignButtonPressed extends HomeEvent {
  final String campaignId;
  UpdateCampaignButtonPressed({required this.campaignId});
}

class GetPollsEvent extends HomeEvent {
  final String campaignId;
  final bool forceUpdate;
  GetPollsEvent({required this.campaignId, this.forceUpdate = false});
}

class UploadButtonPressed extends HomeEvent {
  final List<AnswersModel> answers;
  UploadButtonPressed({required this.answers});
  
}