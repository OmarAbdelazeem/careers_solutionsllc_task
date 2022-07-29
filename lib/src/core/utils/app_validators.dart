import 'package:careers_solutionsllc_task/src/res/app_strings.dart';

class AppValidators {
  AppValidators._();

 static String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterYourWeight;
    }
    return null;
  }
}
