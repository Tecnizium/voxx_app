import 'package:bloc/bloc.dart';
import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:meta/meta.dart';

import '../../../data/providers/home_api_provider.dart';

part 'answer_poll_event.dart';
part 'answer_poll_state.dart';

class AnswerPollBloc extends Bloc<AnswerPollEvent, AnswerPollState> {
  AnswerPollBloc(
      {HomeApiProvider? homeApiProvider, CacheProvider? cacheProvider})
      : super(AnswerPollInitial()) {
    CacheProvider _cacheProvider = cacheProvider ?? CacheProvider();
    HomeApiProvider _homeApiProvider = homeApiProvider ?? HomeApiProvider();
    List<OptionSelectedModel> optionSelected = [];
    String? lastQuestionId;
    on<AnswerPollEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<BackButtonPressed>((event, emit) {
      optionSelected
          .removeWhere((element) => element.questionId == lastQuestionId);
    });

    on<NextButtonPressed>(
      (event, emit) {
        lastQuestionId = event.questionId;
        for (var element in event.text) {
          if (element.isNotEmpty) {
            optionSelected.add(OptionSelectedModel(
                questionId: event.questionId, value: element));
          }
        }
      },
    );

    on<FinishButtonPressed>((event, emit) async {
      for (var element in event.text) {
        if (element.isNotEmpty) {
          optionSelected.add(OptionSelectedModel(
              questionId: event.questionId, value: element));
        }
      }

      final connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        try {
          emit(AnswerPollLoading());

          final jwtToken = await _cacheProvider.jwtToken;
          final response = await _homeApiProvider.sendAnswersPoll(
              AnswersModel(pollId: event.pollId, answers: optionSelected),
              jwtToken);
          if (response.statusCode == 200) {
            emit(AnswerPollSuccess());
          } else {
            emit(AnswerPollError(message: response.data));
          }
        } catch (e) {
          emit(AnswerPollError(message: e.toString()));
        }
      } else {
        final answersCache = await _cacheProvider.answers;
        answersCache
            .add(AnswersModel(pollId: event.pollId, answers: optionSelected));
        await _cacheProvider.setAnswers(answersCache);
        emit(AnswerPollSuccess());
      }
    });
  }
}
