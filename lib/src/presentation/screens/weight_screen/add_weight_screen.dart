import 'package:careers_solutionsllc_task/src/bloc/weights_cubit/weights_cubit.dart';
import 'package:careers_solutionsllc_task/src/core/utils/app_validators.dart';
import 'package:careers_solutionsllc_task/src/core/utils/loading_dialogue.dart';
import 'package:careers_solutionsllc_task/src/data/models/weight_model/weight_model.dart';
import 'package:careers_solutionsllc_task/src/data/repository/weights_repository.dart';
import 'package:careers_solutionsllc_task/src/presentation/widgets/app_button.dart';
import 'package:careers_solutionsllc_task/src/presentation/widgets/app_text_field.dart';
import 'package:careers_solutionsllc_task/src/presentation/widgets/error_view.dart';
import 'package:careers_solutionsllc_task/src/res/app_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../core/utils/decimal_text_input_formatter.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen({Key? key}) : super(key: key);

  @override
  State<AddWeightScreen> createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  final TextEditingController weightController = TextEditingController();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final _formKey = GlobalKey<FormState>();
  late WeightsCubit weightsCubit =
      WeightsCubit(context.read<WeightsRepository>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addWeight),
      ),
      body: BlocProvider<WeightsCubit>(
        create: (_)=> weightsCubit,
        child: BlocConsumer<WeightsCubit, WeightsState>(
          listener: (context, state) {
            if (state is AddingWeight) {
              showLoadingDialog(context, _keyLoader);
            } else if (state is WeightAdded) {
              Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
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
                      autoFocus: true,
                      validator: AppValidators.validateWeight,
                      controller: weightController,
                      keyBoardType: TextInputType.number,
                      inputFormatters: [DecimalTextInputFormatter()],
                    ),
                    const SizedBox(height: 10),
                    if (state is AddWeightError) ErrorView(error: state.error),
                    const SizedBox(height: 24),
                    AppButton(
                      onPressed: _onSubmitTapped,
                      title: AppStrings.submit,
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

  void _onSubmitTapped() {
    if (_formKey.currentState!.validate()) {
      WeightModel weight = WeightModel(
          weightValue: double.parse(weightController.text),
          timeStamp: Timestamp.now(),
          id: const Uuid().v4());
      weightsCubit.addWeight(weight);
    }
  }
}
