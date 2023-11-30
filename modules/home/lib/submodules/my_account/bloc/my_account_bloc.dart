import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:home/data/providers/home_api_provider.dart';

part 'my_account_event.dart';
part 'my_account_state.dart';

class MyAccountBloc extends Bloc<MyAccountEvent, MyAccountState> {
  MyAccountBloc(
      {HomeApiProvider? homeApiProvider, CacheProvider? cacheProvider})
      : super(MyAccountInitial()) {
    HomeApiProvider _homeApiProvider = homeApiProvider ?? HomeApiProvider();
    CacheProvider _cacheProvider = cacheProvider ?? CacheProvider();
    on<MyAccountEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SaveButtonPressed>((event, emit) async {
      emit(MyAccountLoading());
      final jwtToken = await _cacheProvider.jwtToken;
      UserModel user = event.user;
      user.password = base64Encode(utf8.encode(user.password!));
      final response = await _homeApiProvider.updateUser(user, jwtToken);
      if (response.statusCode == 200) {
        await _cacheProvider.setUser(user);
        emit(MyAccountSuccess(user: user));
      } else {
        emit(MyAccountFailure());
      }
    });

    on<DeleteButtonPressed>((event, emit) async {
      emit(MyAccountLoading());
      final jwtToken = await _cacheProvider.jwtToken;
      final response =  await _homeApiProvider.deleteUser(event.username, jwtToken);
      if (response.statusCode == 200) {
        await _cacheProvider.clear();
        emit(RedirectToLogin());
      } else {
        emit(MyAccountFailure());
      }
    },);
  }
}
