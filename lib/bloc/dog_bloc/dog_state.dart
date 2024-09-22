import 'package:dog_app/bloc/dog_bloc/dog_event.dart';
import 'package:dog_app/model/dog_breed_model.dart';
import 'package:equatable/equatable.dart';

class DogBlocState extends Equatable {
  const DogBlocState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends DogBlocState {
  @override
  String toString() => 'Uninitialized';
}

class DogStateLoading extends DogBlocState {
  final DogEvent currentEvent;

  const DogStateLoading({required this.currentEvent});
}

class DogStateFailed extends DogBlocState {
  final DogEvent currentEvent;
  final String errorMsg;

  const DogStateFailed({
    required this.currentEvent,
    required this.errorMsg,
  });
}

class DogListLoaded extends DogBlocState {
  final DogBreeds dogBreeds;

  const DogListLoaded(this.dogBreeds);
}

class DogImageLoaded extends DogBlocState {
  final String dogImage;

  const DogImageLoaded({required this.dogImage});
}
