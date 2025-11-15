import 'package:app_demo/errors/recurso_existente.dart';

import '../screens/screens.dart';
import 'package:http/http.dart' as http;

class ArtistaServicio {
  final String baseUrl = ApiConfig.baseUrl;
  final Map<String, String> headers = ApiConfig.defaultHeaders;

  final ApiService apiService =
      ApiService(baseUrl: ApiConfig.baseUrl, headers: ApiConfig.defaultHeaders);

  Future<ApiResponse<Artista>> getColeccionArtistas() {
    return apiService.getDatos<Artista>(
      endpoint: 'artistas',
      fromJson: (json) => Artista.fromJson(json),
      errorContext: 'colección de artistas',
    );
  }

  Future<ApiResponse<Obra>> getObrasArtistaPorNombre(String nombreArtista) {
    return apiService.getDatos<Obra>(
      endpoint: 'coleccion/artista?nombre=$nombreArtista',
      fromJson: (json) => Obra.fromJson(json),
      errorContext: 'colección de obras de artistas',
    );
  }

  Future<ApiResponse<Artista>> postArtista(Artista artista) async {
    final response = await http.post(
      Uri.parse('$baseUrl/artista'),
      headers: headers,
      body: json.encode(artista.toJson()),
    );

    if (response.statusCode != 201) {
      final jsonBody = json.decode(response.body);

      if (response.statusCode == 409) {
        final detalle = jsonBody['detalle'] ?? '';
        throw RecursoExistenteException(detalle);
      }
      throw ApiException(
        'Error en los datos enviados (${response.statusCode})',
      );
    }
    final jsonBody = json.decode(response.body);

    return ApiResponse.fromJsonSingle(
        jsonBody, (json) => Artista.fromPostResponseJson(json));
  }
}
