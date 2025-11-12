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

//   Future<ApiResponse<Artista>> getColeccionArtistas() async {
//     final response =
//         await http.get(Uri.parse('$baseUrl/artistas'), headers: headers);
//
//     if (response.statusCode != 200) {
//       final Map<String, dynamic> jsonBody = json.decode(response.body);
//
//       if (response.statusCode == 404) {
//         final detalle =
//             jsonBody['detalle'] ?? 'Colección artistas no encontrada';
//
//         throw EntidadNoEncontradaException(
//             "Los artistas solicitados nose encuentra", detalle);
//       }
//       throw ApiException(
//           'Ocurrió un error al cargar la obra. Inténtalo de nuevo.');
//     }
//     final Map<String, dynamic> jsonBody = json.decode(response.body);
//     final data = jsonBody['data'];
//
//     if (data == null || data.isEmpty) {
//       throw EntidadNoEncontradaException(
//           'Obra no encontrada', jsonBody['detale'] ?? 'Sin detalle');
//     }
//
//     return ApiResponse.fromJson(
//         json.decode(response.body), (json) => Artista.fromJson(json));
//   }

  Future<ApiResponse<Obra>> getObrasArtistaPorNombre2(
      String nombreArtista) async {
    final response = await http.get(
        Uri.parse('$baseUrl/coleccion/artista?nombre=$nombreArtista'),
        headers: headers);

    if (response.statusCode != 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);

      if (response.statusCode == 404) {
        final detalle = jsonBody['detalle'] ??
            'Colección de obras de artistas no encontrada';

        throw EntidadNoEncontradaException(
            "Obras de artistas solicitado nose encuentra", detalle);
      }
      throw ApiException(
          'Ocurrió un error al cargar la obra. Inténtalo de nuevo.');
    }

    final Map<String, dynamic> jsonBody = json.decode(response.body);
    final data = jsonBody['data'];

    if (data == null || data.isEmpty) {
      throw EntidadNoEncontradaException('Coleccion de Obras no encontrada',
          jsonBody['detale'] ?? 'Sin detalle');
    }

    return ApiResponse.fromJson(
        json.decode(response.body), (json) => Obra.fromJson(json));
  }
}
