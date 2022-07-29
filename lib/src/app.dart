import 'package:careers_solutionsllc_task/src/bloc/authentication_cubit/authentication_cubit.dart';
import 'package:careers_solutionsllc_task/src/data/web_services/authentication_web_services.dart';
import 'package:careers_solutionsllc_task/src/data/web_services/weights_web_services.dart';
import 'package:careers_solutionsllc_task/src/routes/app_router.dart';
import 'package:careers_solutionsllc_task/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/authentication_repository.dart';
import 'data/repository/weights_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) =>
              AuthenticationRepository(AuthenticationWebServices()),
        ),
        RepositoryProvider<WeightsRepository>(
          create: (context) => WeightsRepository(WeightsWebServices()),
        ),
      ],
      child: BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(
                context.read<AuthenticationRepository>(),
              ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.splashScreen,
            onGenerateRoute: AppRouter().onGenerateRoute,
          )),
    );
  }
}
