class DogBreeds {
  final List<DogBreed> breeds;

  DogBreeds({required this.breeds});

  factory DogBreeds.fromJson(Map<String, dynamic> json) {
    List<DogBreed> breedsList = [];

    json.forEach((breedName, subBreedsList) {
      breedsList.add(DogBreed(
        breedName: breedName,
        subBreeds: List<String>.from(subBreedsList),
      ));
    });

    return DogBreeds(breeds: breedsList);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    for (var breed in breeds) {
      data[breed.breedName] = breed.subBreeds;
    }

    return data;
  }
}

class DogBreed {
  final String breedName;
  final List<String> subBreeds;

  DogBreed({required this.breedName, required this.subBreeds});

  factory DogBreed.fromJson(Map<String, dynamic> json) {
    return DogBreed(
      breedName: json['breedName'],
      subBreeds: List<String>.from(json['subBreeds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'breedName': breedName,
      'subBreeds': subBreeds,
    };
  }
}
