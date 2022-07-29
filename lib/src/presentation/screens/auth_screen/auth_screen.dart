import 'package:careers_solutionsllc_task/src/bloc/authentication_cubit/authentication_cubit.dart';
import 'package:careers_solutionsllc_task/src/core/utils/navigation_utils.dart';
import 'package:careers_solutionsllc_task/src/presentation/widgets/error_view.dart';
import 'package:careers_solutionsllc_task/src/res/app_strings.dart';
import 'package:careers_solutionsllc_task/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/loading_dialogue.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.authentication),
      ),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) async {
          if (state is AuthenticationLoading) {
            showLoadingDialog(context, _keyLoader);
          } else if (state is AuthenticationFailed ||
              state is AuthenticationError) {
            Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
          } else if (state is AuthenticationSuccess) {
            Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
            NavigationUtils.pushNamedAndPopUntil(AppRoutes.homeScreen, context);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text(AppStrings.loginAnonymously),
                  onPressed: () => _onLoginAnonymouslyTapped(context),
                ),
                const SizedBox(height: 24),
                if (state is AuthenticationError) ErrorView(error: state.error)
              ],
            ),
          );
        },
      ),
    );
  }

  void _onLoginAnonymouslyTapped(BuildContext context) {
    context.read<AuthenticationCubit>().loginAnonymously();
  }
}
