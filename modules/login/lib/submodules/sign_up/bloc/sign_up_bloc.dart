import 'package:bloc/bloc.dart';
import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:meta/meta.dart';

import '../../../data/providers/login_api_provider.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({LoginApiProvider? loginApiProvider, CacheProvider? cacheProvider})
      : super(SignUpInitial()) {
    CacheProvider _cacheProvider = cacheProvider ?? CacheProvider();
    LoginApiProvider _loginApiProvider = loginApiProvider ?? LoginApiProvider();

    on<SignUpEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SignUpButtonPressed>(
      (event, emit) async {
        final connectivityResult = await (Connectivity().checkConnectivity());

        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          emit(SignUpLoading());

          try {
            final response = await _loginApiProvider.signUp(
                event.username, event.email, event.password);

            if (response.statusCode == 200) {
              emit(SignUpSuccess());
            } else {
              emit(SignUpError(response.data));
            }
          } catch (e) {
            emit(SignUpError(e.toString()));
          }
        } else {
          emit(SignUpError('No internet connection'));
        }
      },
    );
  }
}
