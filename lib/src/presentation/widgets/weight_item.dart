import 'package:careers_solutionsllc_task/src/core/utils/navigation_utils.dart';
import 'package:careers_solutionsllc_task/src/core/utils/time_stamp_utils.dart';
import 'package:careers_solutionsllc_task/src/data/models/weight_model/weight_model.dart';
import 'package:careers_solutionsllc_task/src/routes/app_routes.dart';
import 'package:flutter/material.dart';

class WeightItem extends StatelessWidget {
  final WeightModel weight;

  const WeightItem({Key? key, required this.weight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationUtils.pushNamed(
            route: AppRoutes.editWeightScreen,
            context: context,
            arguments: weight);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(weight.weightValue.toString()),
                const SizedBox(height: 10),
                Text(TimestampUtils.formatTimestamp(weight.timeStamp)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
