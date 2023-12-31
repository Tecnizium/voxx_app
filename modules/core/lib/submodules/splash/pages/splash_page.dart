import 'package:commons/colors/app_colors.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:core/submodules/splash/bloc/splash_bloc.dart';
import 'package:core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.kBlue,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      bloc: context.read<SplashBloc>(),
      listener: (context, state) {
        switch (state.runtimeType) {
          case RedirectLogin:
            context.goNamed(AppRoutesName.signIn);
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
              decoration:  BoxDecoration(
                color: AppColors.kBlue,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                width: 200,
                height: 200,
              )),
            
          ],
        );
      },
    );
  }
}
