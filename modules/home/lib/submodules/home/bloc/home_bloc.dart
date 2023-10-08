import 'package:bloc/bloc.dart';
import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:home/data/providers/home_api_provider.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({HomeApiProvider? homeApiProvider, CacheProvider? cacheProvider})
      : super(HomeInitial()) {
    CacheProvider _cacheProvider = cacheProvider ?? CacheProvider();
    HomeApiProvider _homeApiProvider = homeApiProvider ?? HomeApiProvider();

    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LogoutEvent>((event, emit) async {
      _cacheProvider.clear();
    });

    on<GetUserCacheEvent>((event, emit) async {
      final user = await _cacheProvider.user;
      emit(UserCacheLoadedState(user: user));
    });
    on<GetCampaignCacheEvent>(
      (event, emit) async {
        final campaignId = await _cacheProvider.campaignId;
        emit(CampaignCacheLoadedState(campaignId: campaignId));
      },
    );

    on<GetAnswersCacheEvent>(
      (event, emit) async {
        final answers = await _cacheProvider.answers;
        emit(AnswersCacheLoadedState(answers: answers));
      },
    );

    on<UpdateCampaignButtonPressed>((event, emit) async {
      await _cacheProvider.setCampaignId(event.campaignId);
      emit(CampaignCacheLoadedState(campaignId: event.campaignId));
    });

    on<GetPollsEvent>((event, emit) async {
      final connectivityResult = await (Connectivity().checkConnectivity());
      final lastUpdate = await _cacheProvider.lastUpdate;
      final now = DateTime.now();

      if ((now.difference(lastUpdate).inMinutes > 5 &&
          connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) || event.forceUpdate) {
        emit(HomeLoading());
        final jwtToken = await _cacheProvider.jwtToken;
        final response = await _homeApiProvider.getPollsByCampaignId(
            event.campaignId, jwtToken);
        if (response.statusCode == 200) {
          final polls = response.data
              .map<PollModel>((e) => PollModel.fromMap(e))
              .toList();
          await _cacheProvider.setPolls(polls);
          await _cacheProvider.setLastUpdate(now);
          emit(PollsLoadedState(polls: polls));
        } else {
          emit(PollsLoadedState(polls: const []));
        }
      } else {
        final polls = await _cacheProvider.polls;
        emit(PollsLoadedState(polls: polls));
      }
    });

    on<UploadButtonPressed>((event, emit) async {
      final jwtToken = await _cacheProvider.jwtToken;
      for (var answer in event.answers) {
        try {
          final response =
              await _homeApiProvider.sendAnswersPoll(answer, jwtToken);
        } catch (e) {}
      }

      await _cacheProvider.clearAnswers();
    });
  }
}
