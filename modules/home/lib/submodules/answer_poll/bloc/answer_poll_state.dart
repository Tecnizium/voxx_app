part of 'answer_poll_bloc.dart';

@immutable
sealed class AnswerPollState {}

final class AnswerPollInitial extends AnswerPollState {}

final class AnswerPollLoading extends AnswerPollState {}

final class AnswerPollSuccess extends AnswerPollState {}

final class AnswerPollError extends AnswerPollState {
  final String message;
  AnswerPollError({required this.message,});
}