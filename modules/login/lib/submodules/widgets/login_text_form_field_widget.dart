import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

class LoginTextFormField extends StatefulWidget {
  const LoginTextFormField({super.key,
  required this.labelText, required this.controller, this.isPassword = false
  });

  final String labelText;
  final TextEditingController controller;
  final bool isPassword;

  @override
  State<LoginTextFormField> createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  bool? obscureText;
  
  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
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
            color: AppColors.kWhite,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.kWhite,
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