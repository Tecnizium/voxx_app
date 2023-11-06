import 'package:bloc/bloc.dart';
import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:login/data/providers/login_api_provider.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({LoginApiProvider? loginApiProvider, CacheProvider? cacheProvider})
      : super(SignInInitial()) {
    CacheProvider _cacheProvider = cacheProvider ?? CacheProvider();
    LoginApiProvider _loginApiProvider = loginApiProvider ?? LoginApiProvider();

    on<SignInEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SignInButtonPressed>((event, emit) async {
      final connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.wifi ||
              connectivityResult == ConnectivityResult.mobile) {
        emit(SignInLoading());
      try {
        final response =
            await _loginApiProvider.signIn(event.email, event.password);

        if (response.statusCode == 200) {
          final jwtToken = response.data['token'];
          _cacheProvider.setJwtToken(jwtToken);
          final userResponse = await _loginApiProvider.getUser(jwtToken);
          final user = UserModel.fromMap(userResponse.data);
          emit(SignInSuccess(user: user));
        } else {
          emit(SignInError(message: response.data));
        }
      } catch (e) {
        emit(SignInError(message: e.toString()));
      }
      }else{
        emit(SignInError(message: 'No internet connection'));
      }
      
    });
  }
}
