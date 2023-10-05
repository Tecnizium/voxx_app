import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/login_text_form_field_widget.dart';
import '../bloc/sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Size get _size => MediaQuery.of(context).size;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      bloc: context.read<SignUpBloc>(),
      listener: (context, state) {
        switch (state.runtimeType) {
          case SignUpLoading:
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showDialog(
                barrierColor: Colors.transparent,
                barrierDismissible: false,
                context: context,
                builder: (context) => Container());

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  CircularProgressIndicator(
                    color: AppColors.kWhite,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Loading...',
                    style: AppTextTheme.kBody1(color: AppColors.kWhite),
                  ),
                ],
              ),
              backgroundColor: AppColors.kBlue,
            ));
            break;
          case SignUpSuccess:
            context.pop();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Sign up success',
                style: AppTextTheme.kBody1(color: AppColors.kWhite),
              ),
              backgroundColor: AppColors.kGreen,
            ));
            context.goNamed(AppRoutesName.signIn);
            break;
          case SignUpError:
            context.pop();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                (state as SignUpError).message,
                style: AppTextTheme.kBody1(color: AppColors.kWhite),
              ),
              backgroundColor: AppColors.kRed,
            ));
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
                        child: Text('Create\nan account',
                            style: AppTextTheme.kTitle1(
                                color: AppColors.kWhite,
                                fontWeight: FontWeight.w600)),
                      ),
                      Column(
                        children: [
                           LoginTextFormField(
                            labelText: 'CPF',
                            controller: _usernameController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CpfInputFormatter(),
                            ],
                            //onChanged: (value) => context.read<SignUpBloc>().add(LoginEmailChangedEvent(value)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LoginTextFormField(
                            labelText: 'Your Email',
                            controller: _emailController,
                            //onChanged: (value) => context.read<SignUpBloc>().add(LoginEmailChangedEvent(value)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LoginTextFormField(
                            labelText: 'Password',
                            isPassword: true,
                            controller: _passwordController,
                            //onChanged: (value) => context.read<SignUpBloc>().add(LoginPasswordChangedEvent(value)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign up',
                                style: AppTextTheme.kTitle2(
                                    color: AppColors.kBlack),
                              ),
                              IconButton.filled(
                                onPressed: () {
                                  context.read<SignUpBloc>().add(
                                      SignUpButtonPressed(
                                          username: _usernameController.text,
                                          email: _emailController.text,
                                          password: _passwordController.text));
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                      context.goNamed(AppRoutesName.signIn);
                                    },
                                    child: Text('Sign In',
                                        style: AppTextTheme.kBody2(
                                            color: AppColors.kBlack,
                                            fontWeight: FontWeight.w600)),
                                  ),
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
