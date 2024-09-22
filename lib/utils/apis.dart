class ApiUrls {
  static const String baseURL = "https://dog.ceo/api/";
  static const String breedList = "breeds/list/all";
  static String breedImage(String name) => "breed/$name/images/random";
}
