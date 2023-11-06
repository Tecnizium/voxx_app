
import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:core/data/providers/core_api_provider.dart';
import 'package:flutter/material.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({CoreApiProvider? coreApiProvider, CacheProvider? cacheProvider }) : super(SplashInitial()) {
  CoreApiProvider _coreApiProvider = coreApiProvider ??  CoreApiProvider();
  CacheProvider _cacheProvider = cacheProvider ?? CacheProvider();
  

    on<SplashEvent>((event, emit) {
    });

    on<SplashStartEvent>((event, emit) async {
      emit(SplashLoading());
      final jwtToken = await _cacheProvider.jwtToken;
      final user = await _cacheProvider.user;
      if (jwtToken.isNotEmpty) {
         final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
       

        final response = await _coreApiProvider.checkJwtToken(jwtToken);
        if (response.statusCode == 200) {
          final user = UserModel.fromMap(response.data);
          await _cacheProvider.setUser(user);
          emit(RedirectHome(user: user));
        } else {
          emit(RedirectLogin());
        }} else {
          emit(RedirectHome(user: user));
        }
      } else {
        emit(RedirectLogin());
      }
    });
  }
}
