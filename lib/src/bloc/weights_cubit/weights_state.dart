part of 'weights_cubit.dart';

abstract class WeightsState extends Equatable {
  const WeightsState();
}

class WeightsInitial extends WeightsState {
  @override
  List<Object> get props => [];
}

class WeightsLoading extends WeightsState {
  @override
  List<Object> get props => [];
}

class WeightsLoaded extends WeightsState {
  final List<WeightModel> weights;

  const WeightsLoaded(this.weights);

  @override
  List<Object> get props => [weights];
}

class AddingWeight extends WeightsState {
  @override
  List<Object> get props => [];
}

class WeightAdded extends WeightsState {
  final WeightModel weight;

  const WeightAdded(this.weight);

  @override
  List<Object> get props => [];
}

class EditingWeight extends WeightsState {
  @override
  List<Object> get props => [];
}

class DeletingWeight extends WeightsState {
  @override
  List<Object> get props => [];
}

class WeightDeleted extends WeightsState {
  @override
  List<Object> get props => [];
}

class WeightEdited extends WeightsState {
  final WeightModel weight;

  const WeightEdited(this.weight);

  @override
  List<Object> get props => [];
}

class AddWeightError extends WeightsState {
  final String error;

  const AddWeightError(this.error);

  @override
  List<Object> get props => [];
}

class EditWeightError extends WeightsState {
  final String error;

  const EditWeightError(this.error);

  @override
  List<Object> get props => [];
}

class WeightsError extends WeightsState {
  final String error;

  const WeightsError(this.error);

  @override
  List<Object> get props => [error];
}
