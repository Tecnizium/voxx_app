import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:core/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../widgets/login_text_form_field_widget.dart';
import '../bloc/sign_in_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Size get _size => MediaQuery.of(context).size;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      bloc: context.read<SignInBloc>(),
      listener: (context, state) {
        switch (state.runtimeType) {
          case SignInLoading:
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            SnackBarWidget.loadingSnackBar(context);
            break;
          case SignInSuccess:
            context.pop();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            context.goNamed(AppRoutesName.home,
                extra: (state as SignInSuccess).user);
            break;
          case SignInError:
            context.canPop() ? context.pop() : null;
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            SnackBarWidget.errorSnackBar(
                context, (state as SignInError).message);
            break;
          default:
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.kLightBlue3,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                    right: 0,
                    child: SvgPicture.asset(
                        'assets/images/Circle_3_SIDE_BOTTEM.svg')),
                SvgPicture.asset(
                  'assets/images/Circle_2_MID.svg',
                  width: _size.width,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    width: _size.width,
                    child: SvgPicture.asset('assets/images/Circle_1_TOP.svg')),
                Container(
                  width: _size.width,
                  height: _size.height,
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: _size.height * 0.4,
                        child: Text('Welcome\nBack',
                            style: AppTextTheme.kTitle1(
                                color: AppColors.kWhite,
                                fontWeight: FontWeight.w600)),
                      ),
                      Column(
                        children: [
                          LoginTextFormField(
                            labelText: 'Your Email',
                            controller: _emailController,
                            //onChanged: (value) => context.read<SignInBloc>().add(LoginEmailChangedEvent(value)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LoginTextFormField(
                            labelText: 'Password',
                            isPassword: true,
                            controller: _passwordController,
                            //onChanged: (value) => context.read<SignInBloc>().add(LoginPasswordChangedEvent(value)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: AppTextTheme.kTitle2(
                                    color: AppColors.kBlack),
                              ),
                              IconButton.filled(
                                onPressed: () {
                                  //if (_emailController.text.isEmpty) {
                                  //  ScaffoldMessenger.of(context)
                                  //      .hideCurrentSnackBar();
                                  //  SnackBarWidget.errorSnackBar(
                                  //      context, 'Email is empty');
                                  //} else if (!emailValidator(
                                  //    _emailController.text)) {
                                  //  ScaffoldMessenger.of(context)
                                  //      .hideCurrentSnackBar();
                                  //  SnackBarWidget.errorSnackBar(
                                  //      context, 'Email is invalid');
                                  //} else if (_passwordController.text.isEmpty) {
                                  //  ScaffoldMessenger.of(context)
                                  //      .hideCurrentSnackBar();
                                  //  SnackBarWidget.errorSnackBar(
                                  //      context, 'Password is empty');
                                  //} else if (!passwordValidator(
                                  //    _passwordController.text)) {
                                  //  ScaffoldMessenger.of(context)
                                  //      .hideCurrentSnackBar();
                                  //  SnackBarWidget.errorSnackBar(
                                  //      context, 'Password is invalid');
                                  //} else {
                                    context.read<SignInBloc>().add(
                                        SignInButtonPressed(
                                            email: _emailController.text,
                                            password:
                                                _passwordController.text));
                                  //}
                                },
                                icon: const Icon(Icons.arrow_forward_ios),
                                color: AppColors.kWhite,
                                style: IconButton.styleFrom(
                                    fixedSize: const Size(64, 64),
                                    backgroundColor: AppColors.kBlue),
                              )
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  Positioned(
                                    bottom: 1,
                                    child: Container(
                                      width: 150,
                                      height: 6,
                                      color: AppColors.kBlue.withOpacity(0.5),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.goNamed(AppRoutesName.signUp);
                                    },
                                    child: Text('Sign Up',
                                        style: AppTextTheme.kBody2(
                                            color: AppColors.kBlack,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Positioned(
                                    bottom: 1,
                                    child: Container(
                                      width: 150,
                                      height: 6,
                                      color: AppColors.kRed.withOpacity(0.5),
                                    ),
                                  ),
                                  Text('Forgot Password ?',
                                      style: AppTextTheme.kBody2(
                                          color: AppColors.kBlack,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
