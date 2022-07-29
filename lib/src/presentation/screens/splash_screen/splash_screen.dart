import 'package:careers_solutionsllc_task/src/bloc/authentication_cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/navigation_utils.dart';
import '../../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 10)).then((value) {
      context.read<AuthenticationCubit>().autoLoginStarted();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            NavigationUtils.pushNamedAndPopUntil(AppRoutes.homeScreen, context);
          } else {
            NavigationUtils.pushNamedAndPopUntil(AppRoutes.authScreen, context);
          }
        },
        child: Container(),
      ),
    );
  }
}
