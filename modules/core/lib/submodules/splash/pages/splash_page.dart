import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:core/submodules/splash/bloc/splash_bloc.dart';
import 'package:core/routes/routes.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      bloc: context.read<SplashBloc>(),
      listener: (context, state) {
        switch (state.runtimeType) {
          case RedirectLogin:
            context.go(AppRoutes.login.path);
            break;
          case RedirectHome:
            context.go(AppRoutes.home.path, extra: (state as RedirectHome).user);
            break;
          default:
        }
      },
      builder: (context, state) {
        if (state is SplashInitial) {
          context.read<SplashBloc>().add(SplashStartEvent());
        }
        return Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF367CFE)
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.none,
                ),
              ),
            ),
            
          ],
        );
      },
    );
  }
}
