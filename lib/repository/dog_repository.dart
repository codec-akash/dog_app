import 'package:dog_app/model/dog_breed_model.dart';
import 'package:dog_app/network/api_provider.dart';
import 'package:dog_app/utils/apis.dart';
import 'package:hive/hive.dart';

class DogRepository extends ApiProvider {
  final Box _breedBox = Hive.box('dogBreedsBox');

  Future<void> cacheBreeds(DogBreeds breeds) async {
    await _breedBox.put('breeds', breeds.toJson());
  }

  Future<DogBreeds> getDogList() async {
    try {
      final breedsJson = _breedBox.get('breeds');
      if (breedsJson != null) {
        return DogBreeds.fromJson(Map<String, dynamic>.from(breedsJson));
      }
      Map<String, dynamic> response = await get(ApiUrls.breedList);
      if (response['result'] != null) {
        DogBreeds dogbreeds = DogBreeds.fromJson(response['result']);
        return dogbreeds;
      } else {
        throw response['error'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getBreedImage(String name) async {
    try {
      Map<String, dynamic> res = await get(ApiUrls.breedImage(name));
      if (res['error'] != null) {
        throw res['error']['message'];
      }
      return res['result'];
    } catch (e) {
      rethrow;
    }
  }
}
