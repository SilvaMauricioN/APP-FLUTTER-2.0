import '../screens/screens.dart';
import 'package:http/http.dart' as http;

class ArtistaServicio {
  final String baseUrl = ApiConfig.baseUrl;
  final Map<String, String> headers = ApiConfig.defaultHeaders;

  Future<ApiResponse<Artista>> getArtistas() async {
    final response =
        await http.get(Uri.parse('$baseUrl/artistas'), headers: headers);
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(
        json.decode(response.body),
        (json) => Artista.fromJson(json),
      );
    }
    throw Exception('Nose puede cargar obras');
  }
}
