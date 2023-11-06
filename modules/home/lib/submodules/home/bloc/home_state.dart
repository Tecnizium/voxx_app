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

final class AnswersCacheLoadedState extends HomeState {
  final List<AnswersModel> answers;
  AnswersCacheLoadedState({
    required this.answers,
    });
}

final class UploadAnswersErrorState extends HomeState {
  final String message;
  final List<AnswersModel> answers;

  UploadAnswersErrorState({
    required this.message,
    required this.answers,
    });
}

final class UploadAnswersLoadingState extends HomeState {}

final class UploadAnswersUploadedState extends HomeState {
  final List<AnswersModel> answers;
  UploadAnswersUploadedState({
    required this.answers,
    });
}

final class PollsLoadedState extends HomeState {
  final List<PollModel> polls;
  PollsLoadedState({
    required this.polls,
    });
}
