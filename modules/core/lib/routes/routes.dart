import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:core/data/providers/core_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:home/data/providers/home_api_provider.dart';
import 'package:login/data/providers/login_api_provider.dart';

import '../core.dart';
import '../submodules/splash/splash.dart';

part 'routes_strings.dart';

abstract class AppRoutes {
  static GoRouter get router => GoRouter(
        routes: routes,
        errorBuilder: (context, state) => const Material(
          child: Center(
            child: Text('Page not found'),
          ),
        ),
      );

  static List<GoRoute> get routes => [splash, signIn, signUp, home, profile];

  static GoRoute get splash => GoRoute(
        path: AppRoutesPath.splash,
        name: AppRoutesName.splash,
        builder: (context, state) => BlocProvider(
          create: (context) => SplashBloc(
              coreApiProvider: CoreApiProvider(),
              cacheProvider: CacheProvider()),
          child: const SplashPage(),
        ),
      );

  static GoRoute get signIn => GoRoute(
        path: AppRoutesPath.signIn,
        name: AppRoutesName.signIn,
        builder: (context, state) => BlocProvider(
          create: (context) => SignInBloc(
              loginApiProvider: LoginApiProvider(),
              cacheProvider: CacheProvider()),
          child: const SignInPage(),
        ),
      );

  static GoRoute get signUp => GoRoute(
        path: AppRoutesPath.signUp,
        name: AppRoutesName.signUp,
        builder: (context, state) => BlocProvider(
          create: (context) => SignUpBloc(
              loginApiProvider: LoginApiProvider(),
              cacheProvider: CacheProvider()),
          child: const SignUpPage(),
        ),
      );
  static GoRoute get home => GoRoute(
          path: AppRoutesPath.home,
          name: AppRoutesName.home,
          builder: (context, state) => BlocProvider(
                create: (context) => HomeBloc(cacheProvider: CacheProvider()),
                child: HomePage(
                  user: state.extra is UserModel ? state.extra as UserModel : null,
                ),
              ),
          routes: [
            GoRoute(
              path: AppRoutesPath.answerPoll,
              name: AppRoutesName.answerPoll,
              builder: (context, state) => BlocProvider(
                create: (context) => AnswerPollBloc(cacheProvider: CacheProvider(), homeApiProvider: HomeApiProvider()),
                child: AnswerPollPage(
                  poll: state.extra as PollModel,
                ),
              ),
            ),
          ]);
  static GoRoute get profile => GoRoute(
        path: AppRoutesPath.profile,
        name: AppRoutesName.profile,
        builder: (context, state) => MultiBlocProvider(providers: [
          BlocProvider(create: (context) => MyAccountBloc(homeApiProvider: HomeApiProvider(), cacheProvider: CacheProvider())),
          BlocProvider(
            create: (context) => HomeBloc(),
          )
        ], child: MyAccountPage(user: state.extra as UserModel)),
      );
}
