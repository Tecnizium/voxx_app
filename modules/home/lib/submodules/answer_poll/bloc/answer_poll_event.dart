part of 'answer_poll_bloc.dart';

@immutable
sealed class AnswerPollEvent {}

class BackButtonPressed extends AnswerPollEvent {
  BackButtonPressed();
}

class NextButtonPressed extends AnswerPollEvent {
  final String questionId;
  final List<String> text;
  NextButtonPressed({required this.questionId, required this.text,});
}

class FinishButtonPressed extends AnswerPollEvent {
  final String pollId;
  final String questionId;
  final List<String> text;
  FinishButtonPressed({required this.pollId, required this.questionId, required this.text,});
}