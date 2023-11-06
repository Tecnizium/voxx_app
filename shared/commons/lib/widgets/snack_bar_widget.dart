import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

abstract class SnackBarWidget {
  static void loadingSnackBar(BuildContext context) {
    showDialog(
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        context: context,
        builder: (context) => Container());

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1000),
      dismissDirection: DismissDirection.none,
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
  }

  static void errorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: AppTextTheme.kBody1(color: AppColors.kWhite),
      ),
      backgroundColor: AppColors.kRed,
    ));
  }

  static void successSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: AppTextTheme.kBody1(color: AppColors.kWhite),
      ),
      backgroundColor: AppColors.kGreen,
    ));
  }
}
