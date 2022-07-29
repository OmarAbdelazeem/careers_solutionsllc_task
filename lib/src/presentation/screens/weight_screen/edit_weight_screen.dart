import 'package:careers_solutionsllc_task/src/bloc/weights_cubit/weights_cubit.dart';
import 'package:careers_solutionsllc_task/src/core/utils/loading_dialogue.dart';
import 'package:careers_solutionsllc_task/src/data/models/weight_model/weight_model.dart';
import 'package:careers_solutionsllc_task/src/data/repository/weights_repository.dart';
import 'package:careers_solutionsllc_task/src/presentation/widgets/app_text_field.dart';
import 'package:careers_solutionsllc_task/src/presentation/widgets/error_view.dart';
import 'package:careers_solutionsllc_task/src/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_validators.dart';
import '../../../core/utils/decimal_text_input_formatter.dart';
import '../../widgets/app_button.dart';

class EditWeightScreen extends StatefulWidget {
  const EditWeightScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditWeightScreen> createState() => _EditWeightScreenState();
}

class _EditWeightScreenState extends State<EditWeightScreen> {
  late TextEditingController weightController;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final _formKey = GlobalKey<FormState>();
  late WeightsCubit weightsCubit =
      WeightsCubit(context.read<WeightsRepository>());

  @override
  Widget build(BuildContext context) {
    final weight = ModalRoute.of(context)!.settings.arguments as WeightModel;
    weightController =
        TextEditingController(text: weight.weightValue.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.editWeight),
        actions: [
          IconButton(
              onPressed: () => _onDeleteTapped(weight.id),
              icon: const Icon(Icons.delete))
        ],
      ),
      body: BlocProvider<WeightsCubit>(
        create: (_) => weightsCubit,
        child: BlocConsumer<WeightsCubit, WeightsState>(
          listener: (context, state) {
            if (state is EditingWeight || state is DeletingWeight) {
              showLoadingDialog(context, _keyLoader);
            } else if (state is WeightEdited || state is WeightDeleted) {
              Navigator.of(_keyLoader.currentContext!, rootNavigator: true)
                  .pop();
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextField(
                      validator: AppValidators.validateWeight,
                      autoFocus: true,
                      controller: weightController,
                      keyBoardType: TextInputType.number,
                      inputFormatters: [DecimalTextInputFormatter()],
                    ),
                    const SizedBox(height: 10),
                    if (state is EditWeightError) ErrorView(error: state.error),
                    const SizedBox(height: 24),
                    AppButton(
                      onPressed: () => _onEditTapped(weight),
                      title: AppStrings.edit,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onEditTapped(WeightModel oldWeight) {
    if (_formKey.currentState!.validate()) {
      WeightModel weight = WeightModel(
          weightValue: double.parse(weightController.text),
          timeStamp: oldWeight.timeStamp,
          id: oldWeight.id);
      weightsCubit.editWeight(weight);
    }
  }

  void _onDeleteTapped(String id) {
    weightsCubit.deleteWeight(id);
  }
}
