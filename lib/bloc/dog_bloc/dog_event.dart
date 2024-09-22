import 'package:equatable/equatable.dart';

class DogEvent extends Equatable {
  const DogEvent();

  @override
  List<Object> get props => [];
}

class LoadDogList extends DogEvent {
  const LoadDogList();

  @override
  List<Object> get props => [];
}

class LoadDogImage extends DogEvent {
  final String name;

  const LoadDogImage({required this.name});
}
