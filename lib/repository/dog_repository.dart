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
        DogBreeds dogBreeds = DogBreeds.fromJson(response['result']);
        return dogBreeds;
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

var resp = {
  "weimaraner": [],
  "whippet": [],
  "wolfhound": ["irish"],
  "affenpinscher": [],
  "african": [],
  "airedale": [],
  "akita": [],
  "appenzeller": [],
  "australian": ["kelpie", "shepherd"],
  "bakharwal": ["indian"],
  "basenji": [],
  "beagle": [],
  "bluetick": [],
  "borzoi": [],
  "bouvier": [],
  "boxer": [],
  "brabancon": [],
  "briard": [],
  "buhund": ["norwegian"],
  "bulldog": ["boston", "english", "french"],
  "bullterrier": ["staffordshire"],
  "cattledog": ["australian"],
  "cavapoo": [],
  "chihuahua": [],
  "chippiparai": ["indian"],
  "chow": [],
  "clumber": [],
  "cockapoo": [],
  "collie": ["border"],
  "coonhound": [],
  "corgi": ["cardigan"],
  "cotondetulear": [],
  "dachshund": [],
  "dalmatian": [],
  "dane": ["great"],
  "danish": ["swedish"],
  "deerhound": ["scottish"],
  "dhole": [],
  "dingo": [],
  "doberman": [],
  "elkhound": ["norwegian"],
  "entlebucher": [],
  "eskimo": [],
  "finnish": ["lapphund"],
  "frise": ["bichon"],
  "gaddi": ["indian"],
  "germanshepherd": [],
  "greyhound": ["indian", "italian"],
  "groenendael": [],
  "havanese": [],
  "hound": [
    "afghan",
    "basset",
    "blood",
    "english",
    "ibizan",
    "plott",
    "walker"
  ],
  "husky": [],
  "keeshond": [],
  "kelpie": [],
  "kombai": [],
  "komondor": [],
  "kuvasz": [],
  "labradoodle": [],
  "labrador": [],
  "leonberg": [],
  "lhasa": [],
  "malamute": [],
  "malinois": [],
  "maltese": [],
  "mastiff": ["bull", "english", "indian", "tibetan"],
  "mexicanhairless": [],
  "mix": [],
  "mountain": ["bernese", "swiss"],
  "mudhol": ["indian"],
  "newfoundland": [],
  "otterhound": [],
  "ovcharka": ["caucasian"],
  "papillon": [],
  "pariah": ["indian"],
  "pekinese": [],
  "pembroke": [],
  "pinscher": ["miniature"],
  "pitbull": [],
  "pointer": ["german", "germanlonghair"],
  "pomeranian": [],
  "poodle": ["medium", "miniature", "standard", "toy"],
  "pug": [],
  "puggle": [],
  "pyrenees": [],
  "rajapalayam": ["indian"],
  "redbone": [],
  "retriever": ["chesapeake", "curly", "flatcoated", "golden"],
  "ridgeback": ["rhodesian"],
  "rottweiler": [],
  "saluki": [],
  "samoyed": [],
  "schipperke": [],
  "schnauzer": ["giant", "miniature"],
  "segugio": ["italian"],
  "setter": ["english", "gordon", "irish"],
  "sharpei": [],
  "sheepdog": ["english", "indian", "shetland"],
  "shiba": [],
  "shihtzu": [],
  "spaniel": [
    "blenheim",
    "brittany",
    "cocker",
    "irish",
    "japanese",
    "sussex",
    "welsh"
  ],
  "spitz": ["indian", "japanese"],
  "springer": ["english"],
  "stbernard": [],
  "terrier": [
    "american",
    "australian",
    "bedlington",
    "border",
    "cairn",
    "dandie",
    "fox",
    "irish",
    "kerryblue",
    "lakeland",
    "norfolk",
    "norwich",
    "patterdale",
    "russell",
    "scottish",
    "sealyham",
    "silky",
    "tibetan",
    "toy",
    "welsh",
    "westhighland",
    "wheaten",
    "yorkshire"
  ],
  "tervuren": [],
  "vizsla": [],
  "waterdog": ["spanish"],
};
