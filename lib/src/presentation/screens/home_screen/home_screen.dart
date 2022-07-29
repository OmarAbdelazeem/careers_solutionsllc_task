import 'package:careers_solutionsllc_task/src/bloc/authentication_cubit/authentication_cubit.dart';
import 'package:careers_solutionsllc_task/src/bloc/weights_cubit/weights_cubit.dart';
import 'package:careers_solutionsllc_task/src/core/utils/navigation_utils.dart';
import 'package:careers_solutionsllc_task/src/data/models/weight_model/weight_model.dart';
import 'package:careers_solutionsllc_task/src/data/repository/weights_repository.dart';
import 'package:careers_solutionsllc_task/src/presentation/screens/weight_screen/add_weight_screen.dart';
import 'package:careers_solutionsllc_task/src/presentation/widgets/error_view.dart';
import 'package:careers_solutionsllc_task/src/presentation/widgets/loading_view.dart';
import 'package:careers_solutionsllc_task/src/presentation/widgets/weight_item.dart';
import 'package:careers_solutionsllc_task/src/res/app_strings.dart';
import 'package:careers_solutionsllc_task/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeightsCubit weightsCubit =
      WeightsCubit(context.read<WeightsRepository>());

  @override
  void initState() {
    weightsCubit.listenToWeights();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.weights),
        actions: [
          BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationLoggedOut) {
                NavigationUtils.pushNamedAndPopUntil(
                    AppRoutes.authScreen, context);
              }
            },
            child: IconButton(
                onPressed: _onExitTapped, icon: const Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: BlocProvider<WeightsCubit>(
        create: (_) => weightsCubit,
        child: BlocBuilder<WeightsCubit, WeightsState>(
          builder: (context, state) {
            if (state is WeightsLoading) {
              return const LoadingView();
            } else if (state is WeightsError) {
              return Center(child: ErrorView(error: state.error));
            }
            return _buildWeights();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddTapped,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onAddTapped() {
    NavigationUtils.pushScreen(
        screen: const AddWeightScreen(), context: context);
  }

  void _onExitTapped() {
    context.read<AuthenticationCubit>().logout();
  }

  Widget _buildWeights() {
    List<WeightModel> weights = weightsCubit.weights;
    return ListView.builder(
      itemCount: weights.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return WeightItem(weight: weights[index]);
      },
    );
  }
}
