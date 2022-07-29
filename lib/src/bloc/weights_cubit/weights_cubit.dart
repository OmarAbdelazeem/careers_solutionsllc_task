import 'package:careers_solutionsllc_task/src/data/models/weight_model/weight_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/weights_repository.dart';

part 'weights_state.dart';

class WeightsCubit extends Cubit<WeightsState> {
  final WeightsRepository _weightsRepository;

  WeightsCubit(this._weightsRepository) : super(WeightsInitial());
  List<WeightModel> _weights = [];

  Future<void> listenToWeights() async {
    try {
      emit(WeightsLoading());
      await for (var item in _weightsRepository.getWeights()) {
        _weights = item.toList();
        emit(WeightsLoaded(_weights));
      }
    } catch (e) {
      emit(WeightsError(e.toString()));
      print(e.toString());
    }
  }

  Future<void> addWeight(WeightModel weight) async {
    try {
      emit(AddingWeight());
      await _weightsRepository.addWeight(weight);
      emit(WeightAdded(weight));
    } catch (e) {
      print(e.toString());
      emit(WeightsError(e.toString()));
    }
  }

  Future<void> editWeight(WeightModel weight) async {
    try {
      emit(EditingWeight());
      await _weightsRepository.editWeight(weight);
      emit(WeightEdited(weight));
    } catch (e) {
      print(e.toString());
      emit(WeightsError(e.toString()));
    }
  }

  Future<void> deleteWeight(String id) async {
    try {
      emit(DeletingWeight());
      await _weightsRepository.deleteWeight(id);
      emit(WeightDeleted());
    } catch (e) {
      print(e.toString());
      emit(WeightsError(e.toString()));
    }
  }

  List<WeightModel> get weights => _weights;
}
