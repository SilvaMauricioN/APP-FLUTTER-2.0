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

    return apiService.modifyDatos(response, 201);
  }

  Future<ApiResponse<Artista>> updateArtista(Artista artista) async {
    final response = await http.put(
      Uri.parse('$baseUrl/artista/${artista.idPrincipalMaker}'),
      headers: headers,
      body: json.encode(artista.toJson()),
    );

    return apiService.modifyDatos(response, 200);
  }
}
