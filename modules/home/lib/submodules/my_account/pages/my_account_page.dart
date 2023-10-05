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

  late TextEditingController firstNameController =
      TextEditingController(text: widget.user.firstName);
  late TextEditingController lastNameController =
      TextEditingController(text: widget.user.lastName);
  late TextEditingController emailController =
      TextEditingController(text: widget.user.email);
  late TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyAccountBloc, MyAccountState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case MyAccountLoading:
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
          case MyAccountSuccess:
            context.pop();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'User updated successfully',
                style: AppTextTheme.kBody1(color: AppColors.kWhite),
              ),
              backgroundColor: Colors.green,
            ));
            break;
          case MyAccountFailure:
            context.pop();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Something went wrong',
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
                            widget.user.firstName!,
                            style:
                                AppTextTheme.kTitle3(color: AppColors.kWhite),
                          )
                        ],
                      )),
                  HomeListTile(
                    title: 'Home',
                    onTap: () {
                      context.goNamed(AppRoutesName.home, extra: widget.user);
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
                      context.goNamed(AppRoutesName.login);
                    },
                  )
                ],
              ),
            ),
            appBar: AppBar(
              iconTheme: IconThemeData(color: AppColors.kWhite, size: 30),
              backgroundColor: AppColors.kBlue,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(20),
                  width: _size.width * 0.9,
                  height: _size.height * 0.85,
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
                              context.read<MyAccountBloc>().add(
                                  SaveButtonPressed(
                                      user: UserModel(
                                          id: widget.user.id,
                                          username: widget.user.username,
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          role: widget.user.role)));
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(_size.width * 0.3, 40),
                                backgroundColor: AppColors.kBlue,
                                elevation: 0),
                            child: Text(
                              'Save',
                              style:
                                  AppTextTheme.kBody1(color: AppColors.kWhite),
                            ),
                          )),
                    ],
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
