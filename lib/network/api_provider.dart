import 'package:dog_app/network/api_response_handler.dart';
import 'package:dog_app/utils/apis.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<Map<String, dynamic>> get(String endPoint,
      {Map<String, dynamic>? queryParam}) async {
    String urlString = ApiUrls.baseURL + endPoint;
    Uri url = Uri.parse(urlString);

    Map<String, String> header = await _getHeaders();

    try {
      var response = await http.get(url, headers: header);
      Map<String, dynamic> res = ApiResponseHandler.output(response);
      return res;
    } catch (e) {
      return ApiResponseHandler.outputError(urlString);
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Content-Type": "application/json; charset=utf-8",
    };

    return headers;
  }
}
