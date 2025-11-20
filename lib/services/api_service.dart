import 'package:app_demo/screens/screens.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final Map<String, String> headers;

  ApiService({
    required this.baseUrl,
    required this.headers,
  });

  Future<ApiResponse<T>> getDatos<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    required String errorContext,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: headers,
    );
    if (response.statusCode != 200) {
      final jsonBody = json.decode(response.body);

      if (response.statusCode == 404) {
        final detalle = jsonBody['detalle'] ?? 'Recurso no encontrado';
        throw EntidadNoEncontradaException(
          '$errorContext no encontrado',
          detalle,
        );
      }

      throw ApiException(
        'Ocurrió un error al cargar $errorContext. Inténtalo de nuevo.',
      );
    }

    final jsonBody = json.decode(response.body);
    final data = jsonBody['data'];

    if (data == null || data.isEmpty) {
      throw EntidadNoEncontradaException(
        '$errorContext no encontrado',
        jsonBody['detalle'] ?? 'Sin detalle',
      );
    }

    return ApiResponse.fromJson(jsonBody, fromJson);
  }

  Future<ApiResponse<Artista>> modifyDatos(
    http.Response response,
    int statusCode,
  ) async {
    if (response.statusCode != statusCode) {
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
      jsonBody,
      (json) => Artista.fromPostResponseJson(json),
    );
  }
}
