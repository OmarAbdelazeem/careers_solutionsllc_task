import '../models/weight_model/weight_model.dart';
import '../web_services/weights_web_services.dart';

class WeightsRepository {
  final WeightsWebServices _weightsWebServices;

  WeightsRepository(this._weightsWebServices);


  Stream<Iterable<WeightModel>> getWeights() {
    return _weightsWebServices
        .getWeightsSnapshots()
        .map((event) => event.docs
            .map((e) => WeightModel.fromJson(e.data() as Map<String, dynamic>)));
  }

  Future<void> addWeight(WeightModel weight) async {
    await _weightsWebServices.addWeight(weight.toJson());
  }

  Future<void> editWeight(WeightModel weight) async {
    await _weightsWebServices.editWeight(weight.toJson());
  }

  Future<void> deleteWeight(String id) async {
    await _weightsWebServices.deleteWeight(id);
  }
}
