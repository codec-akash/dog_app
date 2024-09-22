import 'package:dog_app/bloc/dog_bloc/dog_event.dart';
import 'package:dog_app/bloc/dog_bloc/dog_state.dart';
import 'package:dog_app/model/dog_breed_model.dart';
import 'package:dog_app/repository/dog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogBloc extends Bloc<DogEvent, DogBlocState> {
  final DogRepository dogRepo = DogRepository();

  DogBreeds? dogBreeds;

  DogBloc() : super(Uninitialized()) {
    on<LoadDogList>(_loadDog);
    on<LoadDogImage>(_loadDogImage);
  }

  Future<void> _loadDog(LoadDogList event, Emitter<DogBlocState> emit) async {
    try {
      emit(DogStateLoading(currentEvent: event));
      if (dogBreeds != null) {
        emit(DogListLoaded(dogBreeds!));
        return;
      }
      dogBreeds = await dogRepo.getDogList();
      emit(DogListLoaded(dogBreeds!));
    } catch (e) {
      emit(DogStateFailed(currentEvent: event, errorMsg: e.toString()));
    }
  }

  Future<void> _loadDogImage(
      LoadDogImage event, Emitter<DogBlocState> emit) async {
    try {
      emit(DogStateLoading(currentEvent: event));
      String dogImageUrl = await dogRepo.getBreedImage(event.name);
      emit(DogImageLoaded(dogImage: dogImageUrl));
    } catch (e) {
      emit(DogStateFailed(currentEvent: event, errorMsg: e.toString()));
    }
  }
}
