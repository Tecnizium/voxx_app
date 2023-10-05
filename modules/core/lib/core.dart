library core;

export 'package:login/login.dart';
export 'package:home/home.dart';
export 'routes/routes.dart';

import 'package:commons/colors/app_colors.dart';
import 'package:core/routes/routes.dart';
import 'package:flutter/material.dart';

class VoxxApp extends StatelessWidget {
  const VoxxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: AppColors.kWhite),
        colorSchemeSeed: AppColors.kBlue,
        useMaterial3: true
      ),
      routerConfig: AppRoutes.router,
    );
  }
}
