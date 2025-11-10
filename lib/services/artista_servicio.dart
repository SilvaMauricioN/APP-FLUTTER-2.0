import '../screens/screens.dart';
import 'package:http/http.dart' as http;

class ArtistaServicio {
  final String baseUrl = ApiConfig.baseUrl;
  final Map<String, String> headers = ApiConfig.defaultHeaders;

  Future<ApiResponse<Artista>> getColeccionArtistas() async {
    final response =
        await http.get(Uri.parse('$baseUrl/artistas'), headers: headers);

    if (response.statusCode != 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);

      if (response.statusCode == 404) {
        final detalle =
            jsonBody['detalle'] ?? 'Colección artistas no encontrada';

        throw EntidadNoEncontradaException(
            "Los artistas solicitados nose encuentra", detalle);
      }
      throw ApiException(
          'Ocurrió un error al cargar la obra. Inténtalo de nuevo.');
    }
    final Map<String, dynamic> jsonBody = json.decode(response.body);
    final data = jsonBody['data'];

    if (data == null || data.isEmpty) {
      throw EntidadNoEncontradaException(
          'Obra no encontrada', jsonBody['detale'] ?? 'Sin detalle');
    }

    return ApiResponse.fromJson(
        json.decode(response.body), (json) => Artista.fromJson(json));
  }

  Future<ApiResponse<Obra>> getObrasArtista(String nombreArtista) async {
    final response = await http.get(
        Uri.parse('$baseUrl/coleccion/artista?$nombreArtista'),
        headers: headers);
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(
        json.decode(response.body),
        (json) => Obra.fromJson(json),
      );
    }
    throw Exception('Nose puede cargar obras');
  }
}
