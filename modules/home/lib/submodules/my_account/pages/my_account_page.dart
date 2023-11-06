import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:home/submodules/my_account/bloc/my_account_bloc.dart';

class MyAccountPage extends StatefulWidget {
  final UserModel user;
  const MyAccountPage({super.key, required this.user});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  Size get _size => MediaQuery.of(context).size;

  late UserModel user;

  late TextEditingController firstNameController =
      TextEditingController(text: widget.user.firstName);
  late TextEditingController lastNameController =
      TextEditingController(text: widget.user.lastName);
  late TextEditingController emailController =
      TextEditingController(text: widget.user.email);
  late TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyAccountBloc, MyAccountState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case MyAccountLoading:
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            SnackBarWidget.loadingSnackBar(context);
            break;
          case MyAccountSuccess:
            context.pop();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            SnackBarWidget.successSnackBar(
                context, 'User updated successfully');
            user = (state as MyAccountSuccess).user;
            break;
          case MyAccountFailure:
            context.pop();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            SnackBarWidget.errorSnackBar(context, 'Something went wrong');
            break;
          default:
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.kLightBlue3,
            drawer: Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(color: AppColors.kBlue),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            user.firstName ?? user.username ?? '',
                            style:
                                AppTextTheme.kTitle3(color: AppColors.kWhite),
                          )
                        ],
                      )),
                  HomeListTile(
                    title: 'Home',
                    onTap: () {
                      context.goNamed(AppRoutesName.home, extra: user);
                    },
                  ),
                  const HomeListTile(
                    title: 'Settings',
                    selected: true,
                  ),
                  const Spacer(),
                  HomeListTile(
                    title: 'Logout',
                    onTap: () {
                      context.read<HomeBloc>().add(LogoutEvent());
                      context.goNamed(AppRoutesName.signIn);
                    },
                  )
                ],
              ),
            ),
            appBar: AppBar(
              iconTheme: IconThemeData(color: AppColors.kWhite, size: 30),
              backgroundColor: AppColors.kBlue,
            ),
            body: SizedBox(
              width: _size.width,
              height: _size.height,
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(20),
                    width: _size.width * 0.9,
                    height: _size.height * 0.8,
                    decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.kBlack)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MyAccountTextFormField(
                          controller: firstNameController,
                          labelText: 'First Name',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyAccountTextFormField(
                          controller: lastNameController,
                          labelText: 'Last Name',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyAccountTextFormField(
                          controller: emailController,
                          labelText: 'Email',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyAccountTextFormField(
                          controller: passwordController,
                          labelText: 'Password',
                          isPassword: true,
                        ),
                        const Spacer(),
                        Container(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                if (firstNameController.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  SnackBarWidget.errorSnackBar(
                                      context, 'First name is empty');
                                } else if (!nameValidator(
                                    firstNameController.text)) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  SnackBarWidget.errorSnackBar(
                                      context, 'First name is invalid');
                                } else if (lastNameController.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  SnackBarWidget.errorSnackBar(
                                      context, 'Last name is empty');
                                } else if (!nameValidator(
                                    lastNameController.text)) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  SnackBarWidget.errorSnackBar(
                                      context, 'Last name is invalid');
                                } else if (emailController.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  SnackBarWidget.errorSnackBar(
                                      context, 'Email is empty');
                                } else if (!emailValidator(
                                    emailController.text)) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  SnackBarWidget.errorSnackBar(
                                      context, 'Email is invalid');
                                } else if (passwordController.text.isNotEmpty &&
                                    !passwordValidator(
                                        passwordController.text)) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  SnackBarWidget.errorSnackBar(
                                      context, 'Password is invalid');
                                } else {
                                  context.read<MyAccountBloc>().add(
                                      SaveButtonPressed(
                                          user: UserModel(
                                              id: widget.user.id,
                                              username: widget.user.username,
                                              firstName:
                                                  firstNameController.text,
                                              lastName: lastNameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              role: widget.user.role)));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(_size.width * 0.3, 40),
                                  backgroundColor: AppColors.kBlue,
                                  elevation: 0),
                              child: Text(
                                'Save',
                                style: AppTextTheme.kBody1(
                                    color: AppColors.kWhite),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}

class MyAccountTextFormField extends StatefulWidget {
  const MyAccountTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String labelText;
  final bool isPassword;

  @override
  State<MyAccountTextFormField> createState() => _MyAccountTextFormFieldState();
}

class _MyAccountTextFormFieldState extends State<MyAccountTextFormField> {
  bool? obscureText;

  @override
  void initState() {
    obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText!,
      style: AppTextTheme.kBody1(
          color: AppColors.kBlack, fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: AppTextTheme.kBody1(
            color: AppColors.kBlack, fontWeight: FontWeight.normal),
        fillColor: AppColors.kWhite,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.kBlack,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.kBlack,
          ),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText!;
                  });
                },
                icon: Icon(
                  obscureText! ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.kBlack,
                ),
              )
            : null,
      ),
    );
  }
}
